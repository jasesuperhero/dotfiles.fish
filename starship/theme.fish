#!/usr/bin/env fish

set -l palette (theme_pick catppuccin_mocha catppuccin_latte); or exit 1

sed -i '' -E "s/^palette = .*/palette = \"$palette\"/" $HOME/.config/starship.toml
