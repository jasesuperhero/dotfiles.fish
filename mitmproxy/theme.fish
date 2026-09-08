#!/usr/bin/env fish

# Follow the system light/dark theme by picking the closest built-in mitmproxy
# console palette. mitmproxy has no custom-palette support, so we map:
#   light -> "light"  (pairs with the Catppuccin Latte terminal background)
#   dark  -> "dark"   (pairs with the Catppuccin Mocha terminal background)
# console_palette_transparent (set in config.yaml) lets the terminal's actual
# Catppuccin background show through for a cohesive look.

set -l MITM_PALETTE (theme_pick dark light); or exit 1

alias --save mitmproxy="mitmproxy --set console_palette=$MITM_PALETTE" &>/dev/null
