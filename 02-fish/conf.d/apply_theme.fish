#!/usr/bin/env fish

# --- Debug logging (enabled via THEME_DEBUG=1) ---
function _debug --description "Print debug logs when THEME_DEBUG is set"
    test -n "$THEME_DEBUG"; or return

    printf '[%sDBG%s] %s\n' \
        (set_color --bold blue) \
        (set_color normal) \
        "$argv"
end

# --- Run all theme scripts in parallel ---
function _run_theme_scripts
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

        set -gx FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS
    else
        _debug "no theme scripts found"
    end
end

# --- Check theme file on every prompt ---
function _check_theme_file --on-event fish_prompt
    set -l file_theme (string trim (cat ~/.theme 2>/dev/null))
    if test -n "$file_theme" -a "$file_theme" != "$C_THEME"
        set -gx C_THEME $file_theme
        _run_theme_scripts
    end
end

# --- Apply current theme on shell startup ---
if test -f ~/.theme
    set -gx C_THEME (string trim (cat ~/.theme))
end
