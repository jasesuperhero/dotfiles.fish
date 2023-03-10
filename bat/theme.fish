#!/usr/bin/env fish

switch $C_THEME
  case dark
    set -Ux BAT_THEME "Catppuccin-mocha"
  case light
    set -Ux BAT_THEME "Catppuccin-latte"
  case "*"
    exit 1
end
