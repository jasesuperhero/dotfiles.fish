#!/usr/bin/env fish

switch $C_THEME
  case dark
    set GITUI_THEME "mocha.ron"
  case light
    set GITUI_THEME "latte.ron"
  case "*"
    exit 1
end

alias --save gitui="gitui --theme \"$DOTFILES/gitui/$GITUI_THEME\""
