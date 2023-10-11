#!/usr/bin/env fish

asdf plugin add ruby
asdf install ruby latest
asdf global ruby latest

fish "$DOTFILES/ruby/gems/install.fish"
