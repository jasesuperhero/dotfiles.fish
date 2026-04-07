#!/usr/bin/env fish

switch $C_THEME
  case dark
    sed -i '' -E "s/^palette = .*/palette = \"catppuccin_mocha\"/" $HOME/.config/starship.toml
  case light
    sed -i '' -E "s/^palette = .*/palette = \"catppuccin_latte\"/" $HOME/.config/starship.toml
  case "*"
    exit 1
end
