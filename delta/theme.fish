#!/usr/bin/env fish

set -l DELTA_THEME (theme_pick Catppuccin-mocha Catppuccin-latte); or exit 1

alias --save delta="delta --syntax-theme \"$DELTA_THEME\"" &>/dev/null
