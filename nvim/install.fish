#!/usr/bin/env fish

abbr -a vi 'nvim'

nvim --headless "+PackerSync" "+quit!"
