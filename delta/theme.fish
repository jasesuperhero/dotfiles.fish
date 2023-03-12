#!/usr/bin/env fish

switch $C_THEME
  case dark
    set DELTA_THEME "Catppuccin-mocha"
  case light
    set DELTA_THEME "Catppuccin-latte"
  case "*"
    exit 1
end

alias --save delta="delta --syntax-theme \"$DELTA_THEME\"" &> /dev/null
