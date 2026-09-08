#!/usr/bin/env fish

set -l K9S_THEME (theme_pick mocha.yml latte.yml); or exit 1

cp -rf $DOTFILES/k9s/themes/$K9S_THEME $DOTFILES/k9s/config/skin.yml
