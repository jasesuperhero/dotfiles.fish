#!/usr/bin/env fish

switch $C_THEME
  case dark
    set BTOP_THEME "$DOTFILES/btop/themes/catppuccin_mocha.theme"
  case light
    set BTOP_THEME "$DOTFILES/btop/themes/catppuccin_latte.theme"
  case "*"
    exit 1
end

cp -rf $BTOP_THEME $HOME/.config/btop/themes/current.theme
