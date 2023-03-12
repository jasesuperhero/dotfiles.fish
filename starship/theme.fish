#!/usr/bin/env fish

switch $C_THEME
  case dark
    cp -rf "$DOTFILES/starship/starship_dark.toml" "$DOTFILES/starship/starship.toml"
  case light
    cp -rf "$DOTFILES/starship/starship_light.toml" "$DOTFILES/starship/starship.toml"
  case "*"
    exit 1
end
