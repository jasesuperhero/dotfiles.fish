#!/usr/bin/env fish

git clone https://github.com/AstroNvim/AstroNvim "$DOTFILES/nvim/AstroNvim"
ln -s "$DOTFILES/nvim/user" "$DOTFILES/nvim/AstroNvim/lua/user" || true
ln -sf "$DOTFILES/nvim/AstroNvim" "$HOME/.config/nvim" || true

abbr -a vi 'nvim'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
