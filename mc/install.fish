#!/usr/bin/env fish

mkdir -p $HOME/.local/share/mc/skins && cd $HOME/.local/share/mc/skins && git clone https://github.com/catppuccin/mc.git && ln -s -f ./mc/catppuccin.ini .
