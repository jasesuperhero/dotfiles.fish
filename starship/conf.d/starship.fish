#!/usr/bin/env fish

if command -q starship
    starship init fish | source

    set -Ux STARSHIP_CONFIG "$DOTFILES/starship/starship.toml"
end
