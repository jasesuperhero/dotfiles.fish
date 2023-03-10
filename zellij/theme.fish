#!/usr/bin/env fish

switch $C_THEME
  case dark
    set -Ux ZELLIJ_CONFIG_FILE $DOTFILES/zellij/config/config_dark.kdl
  case light
    set -Ux ZELLIJ_CONFIG_FILE $DOTFILES/zellij/config/config_light.kdl
  case "*"
    exit 1
end
