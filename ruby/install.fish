#!/usr/bin/env fish

set RUBY_VERSION "3.1.1"

asdf plugin add ruby
asdf install ruby $RUBY_VERSION
asdf global ruby $RUBY_VERSION

fish "$DOTFILES/ruby/gems/install.fish"
