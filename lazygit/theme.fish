#!/usr/bin/env fish

set -l LAZYGIT_THEME (theme_pick mocha.yml latte.yml); or exit 1

alias --save lazygit="lazygit --use-config-file=\"$DOTFILES/lazygit/config.yml,$DOTFILES/lazygit/themes/$LAZYGIT_THEME\"" >/dev/null 2>&1
