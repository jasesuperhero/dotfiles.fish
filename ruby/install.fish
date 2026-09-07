#!/usr/bin/env fish

# Use precompiled Ruby binaries instead of compiling from source
# (faster, and the default from mise 2026.8.0 onwards).
mise settings ruby.compile=false

mise install --yes ruby@latest
mise use --global ruby@latest

fish "$DOTFILES/ruby/gems/install.fish"
