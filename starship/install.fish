#!/usr/bin/env fish

function generate_config -a theme
  set STARSHIP_MAIN_CONFIG "$(cat $DOTFILES/starship/config.toml)"

  switch $theme
    case dark
      set STARSHIP_HEADER "palette = \"catppuccin_mocha\""
      set STARSHIP_PALLETE "$(cat $DOTFILES/starship/themes/mocha.toml | string collect)"
      set STARSHIP_CONFIG "$DOTFILES/starship/starship_dark.toml"
    case light
      set STARSHIP_HEADER "palette = \"catppuccin_latte\""
      set STARSHIP_PALLETE "$(cat $DOTFILES/starship/themes/latte.toml | string collect)"
      set STARSHIP_CONFIG "$DOTFILES/starship/starship_light.toml"
    case "*"
      exit 1
  end

  echo $STARSHIP_HEADER > $STARSHIP_CONFIG
  echo -e "\n" >> $STARSHIP_CONFIG
  echo $STARSHIP_MAIN_CONFIG >> $STARSHIP_CONFIG
  echo -e "\n" >> $STARSHIP_CONFIG
  echo $STARSHIP_PALLETE >> $STARSHIP_CONFIG
end

generate_config light
generate_config dark
