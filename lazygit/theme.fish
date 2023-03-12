#!/usr/bin/env fish

switch $C_THEME
  case dark
    set LAZYGIT_THEME "mocha.yml"
  case light
    set LAZYGIT_THEME "latte.yml"
  case "*"
    exit 1
end

alias lazygit="lazygit --use-config-file=\"$DOTFILES/lazygit/config.yml,$DOTFILES/lazygit/themes/$LAZYGIT_THEME\""
