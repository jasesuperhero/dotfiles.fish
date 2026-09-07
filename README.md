# Daniel's dotfiles

Config files for Fish, Neovim, Zellij, Kitty, Ghostty, and more — provisioned
declaratively with [`mise bootstrap`](https://mise.jdx.dev/cli/bootstrap.html) on
**macOS** and **Ubuntu/Debian Linux**.

______________________________________________________________________

<!--toc:start-->

- [How it works](#how-it-works)
- [Installation](#installation)
  - [Fresh machine](#fresh-machine)
  - [Existing machine](#existing-machine)
  - [Preview & status](#preview--status)
  - [Updating](#updating)
- [What gets installed](#what-gets-installed)
- [Architecture](#architecture)
- [Machine-local tools](#machine-local-tools)
- [Conflicts & safety](#conflicts--safety)
- [macOS defaults](#macos-defaults)
- [Theme](#theme)
- [Reverting](#reverting)

<!--toc:end-->

## How it works

One file — [`mise.toml`](mise.toml) — is the source of truth for the whole
machine. `mise bootstrap` reads it and converges the machine to that state:
portable tools, host packages, dotfile symlinks, macOS preferences, the login
shell, and a few small idempotent tasks. The same command runs on macOS and
Ubuntu; platform differences are expressed with `os = "macos"` / `os = "linux"`
inside the one file, not with separate scripts.

`mise.toml` is also installed as the **global** mise config
(`~/.config/mise/config.toml` → this file), so the runtimes and CLIs in
`[tools]` are available everywhere, not just inside `~/.dotfiles`.

## Installation

### Fresh machine

Supported: **macOS** (Apple Silicon; Intel works too) and **Ubuntu/Debian**
(x86_64 and arm64). Prerequisites: `git` and `curl` only.

1. Install mise, then make it available in the current shell (a new shell also
   works):

   ```sh
   curl https://mise.run | sh
   eval "$(~/.local/bin/mise activate bash)"   # bash; use `activate zsh` for zsh
   ```

2. Clone the repo (with submodules — the Neovim config uses one):

   ```sh
   git clone --recurse-submodules \
     https://github.com/jasesuperhero/dotfiles.fish.git ~/.dotfiles
   ```

3. Make the repo the global mise config. This symlinks
   `~/.config/mise/config.toml` → `~/.dotfiles/mise.toml` (backing up any
   existing global config) and seeds an untracked
   `~/.config/mise/config.local.toml` for machine-local tools:

   ```sh
   fish ~/.dotfiles/tasks/adopt-global-config.fish
   ```

4. Provision:

   ```sh
   cd ~/.dotfiles && mise bootstrap
   ```

> `mise bootstrap` prompts once for your git `user.name` / `user.email` (stored
> only in `~/.gitconfig`, never in the repo) and offers to make Fish your login
> shell. Open a new terminal afterwards so Fish + mise activation take effect.

Alternatively, `mise bootstrap --from <git-url> --from-dir ~/.dotfiles` clones
and provisions in one step; run the adoption step (3) afterwards to make the
tools global.

### Existing machine

```sh
cd ~/.dotfiles
git pull --ff-only
mise bootstrap
```

### Preview & status

Nothing is applied until you say so — inspect first:

```sh
mise bootstrap --dry-run          # show every change that would be made
mise bootstrap status             # overall convergence status
mise bootstrap packages status    # host packages (brew/apt)
mise bootstrap dotfiles status    # symlinks
mise bootstrap macos defaults status
```

### Updating

- `mise bootstrap` — converge to the configured state (safe, idempotent; does
  **not** upgrade already-installed tools).
- `mise upgrade` — upgrade the versioned tools in `[tools]`.
- `mise bootstrap packages upgrade` — upgrade the host packages (brew/apt).

## What gets installed

**Cross-platform CLIs** (`[tools]` — same version on macOS and Ubuntu):

| Tool | Description |
| --- | --- |
| [`neovim`](https://neovim.io) | Editor — see [nvim/README.md](nvim/README.md) |
| [`bat`](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [`delta`](https://github.com/dandavison/delta) | Better git diffs |
| [`dust`](https://github.com/bootandy/dust) | Intuitive `du` replacement |
| [`eza`](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [`fd`](https://github.com/sharkdp/fd) | Fast, user-friendly `find` |
| [`fzf`](https://github.com/junegunn/fzf) | Fuzzy finder |
| [`gh`](https://github.com/cli/cli) | GitHub CLI |
| [`k9s`](https://k9scli.io) / [`kubectx`](https://github.com/ahmetb/kubectx) | Kubernetes TUI / context switching |
| [`lazygit`](https://github.com/jesseduffield/lazygit) / [`lazydocker`](https://github.com/jesseduffield/lazydocker) | Git / Docker TUIs |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep) | Fast `grep` (`rg`) |
| [`starship`](https://starship.rs) | Cross-shell prompt |
| [`yazi`](https://yazi-rs.github.io) | Terminal file manager |
| [`zellij`](https://zellij.dev) | Terminal multiplexer |

Plus runtimes managed by [mise](https://mise.jdx.dev) (Node, Python, Ruby, Rust,
Lua) and their CLIs (`prettier`, `eslint`, `black`, `yamllint`, `solargraph`,
`stylua`, …), including the Neovim Node/Python/Ruby providers.

**Terminals:** [Kitty](https://sw.kovidgoyal.net/kitty) and
[Ghostty](https://ghostty.org).

**Claude Code:** Zellij status integration + macOS notifications — see
[claude-code/README.md](claude-code/README.md).

**Editor configs** (symlinked from the repo): Neovim (`nvim/`), Zed
(`zed/config/`), plus assorted app configs (bat, btop, k9s, yazi, ghostty, …).

**macOS apps** (Homebrew casks): Alfred, Bartender, Fork, IINA, Kap,
Karabiner-Elements, Kitty, mitmproxy, Obsidian, RescueTime, Stats, Telegram,
Visual Studio Code. Existing installs are adopted, not replaced.

## Architecture

```
mise.toml (== ~/.config/mise/config.toml)
├── [tools]              portable runtimes + cross-platform CLIs (macOS + Ubuntu)
├── [env]               EDITOR/DOTFILES/PROJECTS/GOPATH/locale + PATH
├── [bootstrap.packages] brew:/brew-cask: (macOS) + apt: (Ubuntu) — host deps only
├── [dotfiles]          symlinks (per-file for fish; whole-dir for app configs)
├── [bootstrap.macos.defaults]  macOS preferences
└── [tasks.bootstrap]   idempotent exceptions: fisher, git identity, ssh,
                        config seeding, dark-notify, fonts, login shell
```

The rule: a tool lives in `[tools]` (shared, one declaration) whenever a mature
cross-platform mise backend gives the same binary on both OSes. Host package
managers are used only for OS libraries, build deps, GUI apps (macOS casks), and
software with no good mise backend. Fish stays the shell; application configs
stay in their component directories; mise owns orchestration.

## Machine-local tools

Tools that are specific to one machine (work tools, `go` pin, etc.) are **not**
tracked here. They live in an untracked `~/.config/mise/config.local.toml`, which
mise loads globally alongside the tracked config. `tasks/adopt-global-config.fish`
seeds it for you.

## Conflicts & safety

- Existing correct symlinks are detected as already-applied — re-running is safe.
- `mise bootstrap` does **not** overwrite unmanaged files by default; a real
  file where a managed symlink is expected surfaces as a conflict rather than
  being deleted. Resolve it, or (deliberately) `mise bootstrap --force-dotfiles`.
- Your `~/.gitconfig` identity, `~/.ssh/config`, `~/.localrc.fish`, and
  fisher-generated files are preserved, never clobbered.

## macOS defaults

Applied declaratively via `[bootstrap.macos.defaults]`; side effects (restarting
Dock/Finder, `chflags`, dark-notify agent) run in `tasks/macos-extras.fish`.
Several legacy tweaks from the old `set-defaults.sh` were **dropped**: the
Gatekeeper-weakening `LSQuarantine=false`; obsolete Dashboard, hibernate/
sleepimage, `tmutil disablelocal`, sudden-motion-sensor and standby tweaks; and
app-specific blocks. Safari prefs are also omitted — Safari is sandboxed, so
`defaults write com.apple.Safari …` fails without Full Disk Access. The system
appearance is **not** forced to Dark — the theme follows it automatically.

## Theme

[Catppuccin](https://github.com/catppuccin/catppuccin) across all tools —
**Mocha** in dark mode, **Latte** in light mode. On macOS the theme switches
automatically with the system appearance via `osx-dark-mode-notify`. Switch
manually with:

```sh
update_theme dark
update_theme light
```

**Font:** [JetBrainsMono Nerd Font](https://www.nerdfonts.com), 16 pt (macOS
cask; Ubuntu user-install).

## Reverting

The migration's rollback mechanism is git history. To remove the dotfiles
entirely:

```sh
rm ~/.config/mise/config.toml           # remove the global symlink
rm -rf ~/.dotfiles ~/.config/fish
```

Then restore your previous global mise config from
`~/.config/mise/config.toml.pre-mise-bootstrap` if present.
