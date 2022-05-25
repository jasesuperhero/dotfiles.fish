#!/usr/bin/env fish

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

fish "$DOTFILES/nodejs/npm/install.fish"
