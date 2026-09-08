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
    else
        _debug "no theme scripts found"
    end
end

# --- Apply the on-disk theme once per theme value ---
# Guarded by a marker so that, with N terminals open, the first shell to notice a
# change rewrites the shared tool configs and the rest skip it. Deliberately NOT
# a lock: the theme scripts do whole-file writes, so a rare concurrent
# double-apply is harmless — and far cheaper than every shell re-applying on
# every toggle (the previous behaviour, which raced N shells over the same files).
function _apply_theme_if_stale --argument-names theme
    set -l marker ~/.theme.applied
    test -r $marker; and test (string trim <$marker 2>/dev/null) = "$theme"; and return
    _run_theme_scripts
    echo $theme >$marker
end

# --- Check theme file on every prompt ---
function _check_theme_file --on-event fish_prompt
    set -l file_theme (string trim <~/.theme 2>/dev/null)
    if test -n "$file_theme" -a "$file_theme" != "$C_THEME"
        set -gx C_THEME $file_theme
        _apply_theme_if_stale $file_theme
    end
end

# --- Apply current theme on shell startup ---
# Interactive-only: the theme.fish children spawned by _run_theme_scripts also
# load conf.d, so applying here unconditionally would make each child recursively
# re-run _run_theme_scripts (a fork storm). Guarding on interactivity limits this
# to real shells, and still (re)applies if the appearance changed while no shell
# was open (marker stale).
if test -f ~/.theme
    set -gx C_THEME (string trim <~/.theme)
    status is-interactive; and _apply_theme_if_stale $C_THEME
end
