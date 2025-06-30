#!/usr/bin/env fish

function apply_theme --on-variable C_THEME -d "Apply light/dark theme to the terminal"
    for theme_installer in $dotfiles/*/theme.fish
        $theme_installer
        # and success $theme_installer
        # or abort $theme_installer
    end
end

function success
    if status --is-login
        echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
    end
end

function abort
    if status --is-login
        echo [(set_color --bold yellow) ABRT (set_color normal)] $argv
        exit 1
    end
end
