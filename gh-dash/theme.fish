#!/usr/bin/env fish

set -l GH_DASH_THEME (theme_pick mocha.yml latte.yml); or exit 1

cat "$DOTFILES/gh-dash/config/base.yml" "$DOTFILES/gh-dash/themes/$GH_DASH_THEME" >"$HOME/.config/gh-dash/config.yml"
