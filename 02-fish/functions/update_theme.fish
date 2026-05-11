#!/usr/bin/env fish

function update_theme -a theme
    echo $theme >~/.theme
    set -gx C_THEME $theme
    _run_theme_scripts
end
