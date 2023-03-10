#!/usr/bin/env fish

switch $C_THEME
  case dark
    fish_config theme choose "Catppuccin Mocha"
  case light
    fish_config theme choose "Catppuccin Latte"
  case "*"
    exit 1
end
