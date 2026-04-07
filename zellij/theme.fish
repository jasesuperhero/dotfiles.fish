#!/usr/bin/env fish

set ZELLIJ_CONFIG_FILE "$HOME/.config/zellij/config.kdl"

switch $C_THEME
  case dark
    sed -i '' -E "s/^theme .*/theme \"catppuccin-mocha\"/" $ZELLIJ_CONFIG_FILE
  case light
    sed -i '' -E "s/^theme .*/theme \"catppuccin-latte\"/" $ZELLIJ_CONFIG_FILE
  case "*"
    exit 1
end
