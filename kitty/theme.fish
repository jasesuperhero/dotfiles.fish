#!/usr/bin/env fish

switch $C_THEME
  case dark
    set KITTY_THEME "$DOTFILES/kitty/config/themes/Catppuccin-Mocha.conf"
  case light
    set KITTY_THEME "$DOTFILES/kitty/config/themes/Catppuccin-Latte.conf"
  case "*"
    exit 1
end

cp -rf $KITTY_THEME $DOTFILES/kitty/config/current-theme.conf
kill -SIGUSR1 $(pgrep kitty)
