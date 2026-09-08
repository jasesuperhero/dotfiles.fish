#!/usr/bin/env fish

set -l BTOP_THEME (theme_pick "$DOTFILES/btop/themes/catppuccin_mocha.theme" "$DOTFILES/btop/themes/catppuccin_latte.theme"); or exit 1

cp -rf $BTOP_THEME $HOME/.config/btop/themes/current.theme
