#!/usr/bin/env fish

set -l GITUI_THEME (theme_pick mocha.ron latte.ron); or exit 1

alias --save gitui="gitui --theme \"$DOTFILES/gitui/$GITUI_THEME\"" &>/dev/null
