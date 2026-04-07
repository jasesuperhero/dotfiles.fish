#!/usr/bin/env fish

# --- Debug logging (enabled via THEME_DEBUG=1) ---
function _debug --description "Print debug logs when THEME_DEBUG is set"
    test -n "$THEME_DEBUG"; or return

    printf '[%sDBG%s] %s\n' \
        (set_color --bold blue) \
        (set_color normal) \
        "$argv"
end

# --- Common log formatter (login shells only) ---
function _log --description "Print formatted status line (login shells only)"
    status --is-login; or return

    set -l color $argv[1]
    set -l label $argv[2]
    set -e argv[1..2]

    printf '[%s%s%s] %s\n' \
        (set_color --bold $color) \
        $label \
        (set_color normal) \
        "$argv"
end

# --- Apply themes in parallel ---
function apply_theme --on-variable C_THEME --description "Apply light/dark theme to the terminal (parallel)"
    set -l pids

    for theme_installer in $DOTFILES/*/theme.fish
        test -f "$theme_installer"; or continue
        test -x "$theme_installer"; or continue

        _debug "starting $theme_installer"

        "$theme_installer" &
        set -l pid $last_pid
        set pids $pids $pid

        _debug "spawned PID $pid for $theme_installer"
    end

    if test (count $pids) -gt 0
        _debug "waiting for: $pids"
        wait $pids
        _debug "all themes finished"
    else
        _debug "no theme scripts found"
    end
end

# --- Success message ---
function success --description "Print success message"
    _log green ' OK ' $argv
end

# --- Abort message ---
function abort --description "Print abort message and exit"
    _log yellow ABRT $argv >&2
    status --is-login; and exit 1
    return 1
end
