#!/usr/bin/env fish

ln -s "$DOTFILES/nvim/custom" "$DOTFILES/nvim/config/lua/custom"

abbr -a vi 'nvim'
nvim --headless "+PackerSync" "+quit!"
