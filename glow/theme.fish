#!/usr/bin/env fish

# GLAMOUR_STYLE is an env var glow reads, so keep it exported (universal so it
# propagates live to other shells).
set -Ux GLAMOUR_STYLE (theme_pick $DOTFILES/glow/themes/dark.json $DOTFILES/glow/themes/light.json); or exit 1
