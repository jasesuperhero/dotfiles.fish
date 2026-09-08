#!/usr/bin/env fish

set -l bg (theme_pick dark light); or exit 1

echo "vim.o.background = \"$bg\"" >~/.vimrc.color
