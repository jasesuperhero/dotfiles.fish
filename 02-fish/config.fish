#!/usr/bin/env fish

export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
export PATH="$HOME/.nest/bin:$PATH"

thefuck --alias | source

# uv
fish_add_path "/Users/daniel/.local/bin"
