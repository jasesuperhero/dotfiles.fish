#!/usr/bin/env fish

function update_theme -a theme
    echo $theme >~/.theme
    set -gx C_THEME $theme
    _run_theme_scripts
    or return 1
    # Record what was applied so per-shell _apply_theme_if_stale can skip redundant work.
    echo $theme >~/.theme.applied
end
