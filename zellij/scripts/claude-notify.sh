#!/bin/sh
set -eu

EVENT="${1:-clear}"

[ -n "${ZELLIJ:-}" ] || exit 0

PIPE_NAME="claude_status"
ICON="$HOME/.dotfiles/claude-code/icon.png"

context() {
    sess="${ZELLIJ_SESSION_NAME:-?}"
    pid="${ZELLIJ_PANE_ID:-?}"
    cwd="${PWD:-?}"
    case "$cwd" in
    "$HOME") cwd="~" ;;
    "$HOME"/*) cwd="~${cwd#$HOME}" ;;
    esac
    printf '%s · pane %s · %s' "$sess" "$pid" "$cwd"
}

notify() {
    subtitle="$1"
    sound="${2:-}"
    [ "$(uname -s)" = "Darwin" ] || return 0

    msg="$(context)"

    if command -v terminal-notifier >/dev/null 2>&1; then
        set -- -title "Claude Code" -subtitle "$subtitle" -message "$msg"
        [ -f "$ICON" ] && set -- "$@" -appIcon "$ICON"
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
