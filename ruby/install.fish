#!/usr/bin/env fish

mise install --yes ruby@latest
mise use --global ruby@latest

fish "$DOTFILES/ruby/gems/install.fish"
