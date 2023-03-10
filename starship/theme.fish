#!/usr/bin/env fish

switch $C_THEME
  case dark
    set -Ux STARSHIP_CONFIG $DOTFILES/starship/config_dark.toml
  case light
    set -Ux STARSHIP_CONFIG $DOTFILES/starship/config_light.toml
  case "*"
    exit 1
end
