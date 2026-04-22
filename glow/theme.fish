#!/usr/bin/env fish

switch $C_THEME
    case dark
        set -Ux GLAMOUR_STYLE $DOTFILES/glow/themes/dark.json
    case light
        set -Ux GLAMOUR_STYLE $DOTFILES/glow/themes/light.json
    case "*"
        exit 1
end
