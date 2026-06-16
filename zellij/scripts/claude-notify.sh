#!/bin/sh
set -eu

EVENT="${1:-clear}"

[ -n "${ZELLIJ:-}" ] || exit 0

PIPE_NAME="claude_status"
ICON="$HOME/.dotfiles/claude-code/icon.png"
ZELLIJ_BIN="/opt/homebrew/bin/zellij"
TERM_BUNDLE="com.mitchellh.ghostty"

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
        terminal-notifier "$@" >/dev/null 2>&1 || true
    else
        if [ -n "$sound" ]; then
            osascript -e "display notification \"$msg\" with title \"Claude Code\" subtitle \"$subtitle\" sound name \"$sound\"" \
                >/dev/null 2>&1 || true
        else
            osascript -e "display notification \"$msg\" with title \"Claude Code\" subtitle \"$subtitle\"" \
                >/dev/null 2>&1 || true
        fi
    fi
}

pipe() {
    printf '%s' "$1" | zellij pipe --name "$PIPE_NAME" >/dev/null 2>&1 || true
}

case "$EVENT" in
stop)
    pipe "✻ done"
    notify "✻ Task finished"
    ;;
notification)
    pipe "● waiting"
    notify "● Waiting for input" "Funk"
    ;;
clear | *)
    pipe ""
    ;;
esac
