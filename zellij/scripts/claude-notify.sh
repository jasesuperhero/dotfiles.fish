#!/bin/sh
set -eu

EVENT="${1:-clear}"

[ -n "${ZELLIJ:-}" ] || exit 0

PIPE_NAME="claude_status"
ICON="$HOME/.dotfiles/claude-code/icon.png"
# Resolve zellij: the hook itself runs with a normal PATH, but keep arch-aware
# fallbacks (Intel /usr/local, Apple Silicon /opt/homebrew) so this isn't pinned
# to one prefix. The click-action (focus_cmd) still needs an absolute path.
ZELLIJ_BIN="$(command -v zellij 2>/dev/null || true)"
[ -n "$ZELLIJ_BIN" ] || for c in /opt/homebrew/bin/zellij /usr/local/bin/zellij; do
    [ -x "$c" ] && ZELLIJ_BIN="$c" && break
done
TERM_BUNDLE="com.mitchellh.ghostty"

# terminal-notifier (and, more rarely, osascript / zellij pipe) can deadlock
# against a busy NotificationCenter and never return. Claude Code blocks on the
# Stop hook until its child exits, so a wedged notifier shows up as an endless
# "running stop hooks…". Cap every external call and fire the notification
# detached so the hook itself always returns promptly.
if command -v timeout >/dev/null 2>&1; then
    TIMEOUT="timeout"
elif command -v gtimeout >/dev/null 2>&1; then
    TIMEOUT="gtimeout"
else
    TIMEOUT=""
fi
guard() { if [ -n "$TIMEOUT" ]; then "$TIMEOUT" "$@"; else
    shift
    "$@"
fi; }

# Shell command wired to the notification's click / "Show" action via
# terminal-notifier -execute. NotificationCenter spawns this detached and
# without Homebrew on PATH, so we use absolute paths. focus-pane-id jumps to
# the originating tab + pane; then we bring the terminal window forward.
focus_cmd() {
    sess="${ZELLIJ_SESSION_NAME:-}"
    pid="${ZELLIJ_PANE_ID:-}"
    [ -n "$sess" ] && [ -n "$pid" ] || return 0
    printf "%s --session '%s' action focus-pane-id '%s' >/dev/null 2>&1; /usr/bin/open -b '%s'" \
        "$ZELLIJ_BIN" "$sess" "$pid" "$TERM_BUNDLE"
}

context() {
    sess="${ZELLIJ_SESSION_NAME:-?}"
    tab="${ZELLIJ_TAB_NAME:-}"
    pid="${ZELLIJ_PANE_ID:-?}"
    cwd="${PWD:-?}"
    case "$cwd" in
    "$HOME") cwd="~" ;;
    "$HOME"/*) cwd="~${cwd#$HOME}" ;;
    esac
    if [ -n "$tab" ]; then
        printf '%s · %s · pane %s · %s' "$sess" "$tab" "$pid" "$cwd"
    else
        printf '%s · pane %s · %s' "$sess" "$pid" "$cwd"
    fi
}

notify() {
    subtitle="$1"
    sound="${2:-}"
    [ "$(uname -s)" = "Darwin" ] || return 0

    msg="$(context)"
    jump="$(focus_cmd)"

    if command -v terminal-notifier >/dev/null 2>&1; then
        set -- -title "Claude Code" -subtitle "$subtitle" -message "$msg"
        [ -f "$ICON" ] && set -- "$@" -appIcon "$ICON"
        [ -n "$jump" ] && set -- "$@" -execute "$jump"
        [ -n "$sound" ] && set -- "$@" -sound "$sound"
        guard 10 terminal-notifier "$@" >/dev/null 2>&1
    else
        if [ -n "$sound" ]; then
            guard 10 osascript -e "display notification \"$msg\" with title \"Claude Code\" subtitle \"$subtitle\" sound name \"$sound\"" \
                >/dev/null 2>&1
        else
            guard 10 osascript -e "display notification \"$msg\" with title \"Claude Code\" subtitle \"$subtitle\"" \
                >/dev/null 2>&1
        fi
    fi
}

pipe() {
    printf '%s' "$1" | guard 5 "$ZELLIJ_BIN" pipe --name "$PIPE_NAME" >/dev/null 2>&1 || true
}

# zellij-attention plugin: appends a per-tab icon on the ORIGINATING pane's tab
# (● waiting / ✻ done), so you can see which tab needs you — not just the single
# global {pipe_claude_status} slot. Broadcast pipe (--name) reaches the loaded
# plugin instance; it auto-clears when you focus the pane. $1 = waiting|completed.
attention() {
    [ -n "${ZELLIJ_PANE_ID:-}" ] && [ -n "$ZELLIJ_BIN" ] || return 0
    guard 5 "$ZELLIJ_BIN" pipe --name "zellij-attention::$1::$ZELLIJ_PANE_ID" >/dev/null 2>&1 || true
}

case "$EVENT" in
stop)
    pipe "✻ done"
    attention completed
    notify "✻ Task finished" >/dev/null 2>&1 &
    ;;
notification)
    pipe "● waiting"
    attention waiting
    notify "● Waiting for input" "Funk" >/dev/null 2>&1 &
    ;;
clear | *)
    pipe ""
    ;;
esac
