#!/usr/bin/env fish

switch $C_THEME
    case dark
        set GH_DASH_THEME "mocha.yml"
    case light
        set GH_DASH_THEME "latte.yml"
    case "*"
        exit 1
end

cat $DOTFILES/gh-dash/config/base.yml $DOTFILES/gh-dash/themes/$GH_DASH_THEME >$DOTFILES/gh-dash/config/config.yml
