#!/usr/bin/env fish

# atuin only reads the theme name from config.toml — the ATUIN_THEME__NAME env
# override is NOT honoured — so rewrite the [theme] name line in place. install.fish
# copies config.toml as a real file (not the repo symlink) so this doesn't churn git.
set -l config $HOME/.config/atuin/config.toml
test -f $config; or exit 0

switch $C_THEME
    case dark
        set theme catppuccin-mocha-mauve
    case light
        set theme catppuccin-latte-mauve
    case "*"
        exit 1
end

sed -i '' -E "s|^name = \".*\"|name = \"$theme\"|" $config
