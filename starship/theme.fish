#!/usr/bin/env fish

switch $C_THEME
  case dark
    set STARSHIP_HEADER "palette = \"catppuccin_mocha\""
    set STARSHIP_PALLETE "$(cat $DOTFILES/starship/themes/mocha.toml | string collect)"
  case light
    set STARSHIP_HEADER "palette = \"catppuccin_latte\""
    set STARSHIP_PALLETE "$(cat $DOTFILES/starship/themes/latte.toml | string collect)"
  case "*"
    exit 1
end

set STARSHIP_MAIN_CONFIG "$(cat $DOTFILES/starship/config.toml)"
set -Ux STARSHIP_CONFIG "$DOTFILES/starship/starship.toml"

echo $STARSHIP_HEADER > $STARSHIP_CONFIG
echo -e "\n" >> $STARSHIP_CONFIG
echo $STARSHIP_MAIN_CONFIG >> $STARSHIP_CONFIG
echo -e "\n" >> $STARSHIP_CONFIG
echo $STARSHIP_PALLETE >> $STARSHIP_CONFIG
