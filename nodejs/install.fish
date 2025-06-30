#!/usr/bin/env fish

mise install --yes nodejs@latest
mise use --global nodejs@latest

fish "$DOTFILES/nodejs/npm/install.fish"
