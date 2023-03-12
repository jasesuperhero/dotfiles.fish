#!/usr/bin/env fish

switch $C_THEME
  case dark
    set K9S_THEME "mocha.yml"
  case light
    set K9S_THEME "latte.yml"
  case "*"
    exit 1
end

cp -rf $DOTFILES/k9s/themes/$K9S_THEME $DOTFILES/k9s/config/skin.yml
