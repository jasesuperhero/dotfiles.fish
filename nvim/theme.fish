#!/usr/bin/env fish

switch $C_THEME
  case dark
    echo "set background=dark" > ~/.vimrc.color
  case light
    echo "set background=light" > ~/.vimrc.color
  case "*"
    exit 1
end
