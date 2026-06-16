#!/usr/bin/env fish

# Use a universal variable (like bat/theme.fish): theme scripts run in subshells
# from apply_theme.fish, so -gx would not propagate to running fish instances.
# ATUIN_THEME__NAME overrides [theme] name in config.toml.
switch $C_THEME
    case dark
        set -Ux ATUIN_THEME__NAME catppuccin-mocha-mauve
    case light
        set -Ux ATUIN_THEME__NAME catppuccin-latte-mauve
    case "*"
        exit 1
end
