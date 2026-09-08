# Claude Code

Configuration for [Claude Code](https://claude.com/claude-code) integrated with this dotfiles environment:

- **Theme switching** — `~/.claude.json` theme follows macOS light/dark mode via `theme.fish`.
- **Zellij notifier** — a per-tab attention icon (via the [zellij-attention](https://github.com/KiryuuLight/zellij-attention) plugin), a global status widget in the zjstatus bar, and a macOS banner when Claude finishes a turn or is waiting on you.
- **Claude.app icon** — extracted to `icon.png` and used by the macOS notifications.

The script and layout pieces live in `bin/`, `zellij/scripts/`, and `zellij/config/layouts/` — only the icon and theme switcher live here.

## Zellij notifier

### What you get

| Event in Claude                             | Tab icon (zellij-attention) | Status bar (zjstatus) | macOS banner                        | Sound |
| ------------------------------------------- | --------------------------- | --------------------- | ----------------------------------- | ----- |
| Claude finished a turn (`Stop`)             | `✻` on the tab              | `✻ done`              | "Claude Code · ✻ Task finished"     | —     |
| Claude is waiting on input (`Notification`) | `●` on the tab              | `● waiting`           | "Claude Code · ● Waiting for input" | Funk  |
| You sent a new prompt (`UserPromptSubmit`)  | (cleared on focus)          | (cleared)             | —                                   | —     |

The tab icon is appended to the originating tab's name (e.g. `work` → `work ●`) and
clears automatically when you focus that pane. Unlike the global status-bar slot, it
tells you **which** tab needs you when several Claude sessions run at once.

The banner body is `<session> · <tab>? · pane <pane-id> · <cwd>`, e.g. `brave-tiger · work · pane 18 · ~/.dotfiles`. Tab name is included when `$ZELLIJ_TAB_NAME` is set in the pane (see [Tab name](#tab-name) below); when it isn't, the body collapses to `<session> · pane <id> · <cwd>`.

Outside Zellij the script is a no-op (guarded by `$ZELLIJ`), so plain-terminal Claude stays silent.

### Pieces

- **`zellij/scripts/claude-notify.sh`** — POSIX sh dispatcher. Takes one arg: `stop | notification | clear`.
  - Pipes global status into zjstatus via `zellij pipe --name claude_status -- "<msg>"`.
  - Broadcasts a per-tab pipe to the zellij-attention plugin: `zellij-attention::completed|waiting::$ZELLIJ_PANE_ID`.
  - Fires `terminal-notifier` (preferred) or `osascript` (fallback) for the banner.
  - Uses `claude-code/icon.png` as the banner icon when `terminal-notifier` is available.
- **`zellij/config/config.kdl`** — declares and `load_plugins` the pinned `zellij-attention` wasm with `waiting_icon "●"` / `completed_icon "✻"` (matching the status-bar/banner glyphs).
- **`zellij/config/layouts/default_start.kdl`** — adds `{pipe_claude_status}` to `format_right` and a `pipe_claude_status_format` definition next to the existing `pipe_zjstatus_hints_format`.
- **`~/.claude/settings.json`** — *not in this repo* (per-user, contains tokens). See setup below.

### One-time setup

1. **Install dependencies** (provisioned by `mise bootstrap` via `mise.toml` `[bootstrap.packages]` → `brew:terminal-notifier`):

   ```sh
   brew install terminal-notifier
   ```

   `terminal-notifier` is what enables the custom Claude icon and the rich title/subtitle/message layout. Without it the script falls back to `osascript` (Script Editor icon, plain banner).

1. **Refresh the Claude icon** if Claude.app updates:

   ```sh
   sips -s format png /Applications/Claude.app/Contents/Resources/electron.icns \
       --out ~/.dotfiles/claude-code/icon.png
   ```

1. **Wire the hooks** in `~/.claude/settings.json` (this file is not symlinked from the repo because it carries per-machine tokens). Add the following entries inside the existing top-level `"hooks"` object — preserve any other hooks already there:

   ```json
   "hooks": {
     "Stop": [
       {
         "hooks": [
           { "type": "command", "command": "/Users/<you>/.dotfiles/zellij/scripts/claude-notify.sh stop" }
         ]
       }
     ],
     "Notification": [
       {
         "hooks": [
           { "type": "command", "command": "/Users/<you>/.dotfiles/zellij/scripts/claude-notify.sh notification" }
         ]
       }
     ],
     "UserPromptSubmit": [
       {
         "hooks": [
           { "type": "command", "command": "/Users/<you>/.dotfiles/zellij/scripts/claude-notify.sh clear" }
         ]
       }
     ]
   }
   ```

1. **Reload Zellij** so zjstatus picks up the `pipe_claude_status` slot and the
   `zellij-attention` plugin loads — detach + reattach, or start a fresh session.
   Grant the plugin's permission prompt on first load.

1. **Grant macOS notification permission** to `terminal-notifier` the first time it fires (System Settings → Notifications → terminal-notifier → Allow).

### Verify

Inside a Zellij pane:

```sh
# Status bar widget round-trip
printf '● test' | zellij pipe --name claude_status   # widget appears
printf ''       | zellij pipe --name claude_status   # widget disappears

# Per-tab attention icon round-trip (focus the tab to clear it)
zellij pipe --name "zellij-attention::waiting::$ZELLIJ_PANE_ID"     # tab name gets ●
zellij pipe --name "zellij-attention::completed::$ZELLIJ_PANE_ID"   # tab name gets ✻

# Hook script (banner + widget)
~/.dotfiles/zellij/scripts/claude-notify.sh stop          # ✻ done + silent banner
~/.dotfiles/zellij/scripts/claude-notify.sh notification  # ● waiting + Funk banner
~/.dotfiles/zellij/scripts/claude-notify.sh clear         # widget cleared
```

Then start `claude` in a Zellij pane, ask a one-shot question, and confirm the banner + widget appear when it finishes.

### Why some things look the way they do

- **Tab name comes from a layout-set env var, not the zellij CLI.** `zellij action query-tab-names` and `current-tab-info` return *"There is no active session!"* when called from a Claude hook (a non-attached child process, even via `fish -c`, with a synthetic TTY, or with `--session <name>`). Only `zellij pipe` works headlessly. So the layout sets `ZELLIJ_TAB_NAME` per tab via fish `-C` (see [Tab name](#tab-name)), and the hook reads `$ZELLIJ_TAB_NAME` directly.
- **Per-tab targeting comes from a plugin, not the CLI.** `zellij action rename-pane` only renames the *focused* pane, so it can't target the Claude pane if focus has moved — which is why the zjstatus widget is global. The zellij-attention **plugin** sidesteps this: a broadcast pipe (`--name`) carries the originating `$ZELLIJ_PANE_ID`, and the plugin (which has the full plugin API the CLI lacks) renames whichever tab holds that pane, regardless of focus. So the global widget and the per-tab icon are complementary.
- **Sound only on "waiting".** "Done" fires often and gets noisy with sound. "Waiting" is rarer and worth interrupting for.

## Tab name

Because `zellij action` requires an attached interactive client (zellij 0.44.1), `ZELLIJ_TAB_NAME` is *not* set by zellij itself — we set it from the layout. In `zellij/config/layouts/default_start.kdl`:

```kdl
tab name="work" focus=true {
    pane command="fish" {
        args "--login" "--interactive" "-C" "set -gx ZELLIJ_TAB_NAME work"
    }
}
```

`fish -C "..."` runs the `set -gx` before the shell becomes interactive, so the env var is present in every child (Claude Code, Bash hooks, etc.) without affecting the user's normal shell startup.

**Caveats:**

- Only the layout-declared `"work"` tab gets `ZELLIJ_TAB_NAME`. Tabs you create interactively via `Ctrl+T n` won't have it (the notification body falls back to the no-tab format).
- The env var is captured at pane-launch time. If you rename the tab at runtime via `Ctrl+T r`, `ZELLIJ_TAB_NAME` keeps the original value — it does not track the new name.
- Adding a second declared tab? Mirror the pattern: copy the `pane command="fish" { … }` block and change the env value to match.

## Theme switching

`theme.fish` is invoked by `osx-dark-mode-notify` when macOS appearance changes. It rewrites the `"theme"` key in `~/.claude.json` to `"dark"` or `"light"` (matching Catppuccin Mocha / Latte used elsewhere in the dotfiles).
