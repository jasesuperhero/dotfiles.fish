#!/usr/bin/env fish
# Pick a value for the active theme: prints $dark when C_THEME is "dark", $light
# when it is "light". Returns 1 for any other/unset value, so callers can mirror
# the old `case "*"; exit 1` arm with:  set -l v (theme_pick DARK LIGHT); or exit 1
function theme_pick --argument-names dark light -d "Echo the dark/light value for the current C_THEME"
    switch $C_THEME
        case dark
            echo $dark
        case light
            echo $light
        case '*'
            return 1
    end
end
