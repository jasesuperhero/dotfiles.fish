#!/usr/bin/env fish

ln -s "$DOTFILES/nvim/custom" "$HOME/.config/nvim/config/lua/custom"

abbr -a vi 'nvim'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
