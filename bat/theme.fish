#!/usr/bin/env fish

# BAT_THEME is an env var bat reads, so keep it exported (universal so it
# propagates live to other shells).
set -Ux BAT_THEME (theme_pick Catppuccin-mocha Catppuccin-latte); or exit 1
