#!/usr/bin/env fish

abbr -a vi 'nvim'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
