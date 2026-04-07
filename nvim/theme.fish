#!/usr/bin/env fish

switch $C_THEME
  case dark
    echo 'vim.o.background = "dark"' > ~/.vimrc.color
  case light
    echo 'vim.o.background = "light"' > ~/.vimrc.color
  case "*"
    exit 1
end
