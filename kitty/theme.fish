#!/usr/bin/env fish

switch $C_THEME
  case dark
    kitty +kitten themes --reload-in all "Catppuccin-Mocha"
  case light
    kitty +kitten themes --reload-in all "Catppuccin-Latte"
  case "*"
    exit 1
end
