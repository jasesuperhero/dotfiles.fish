#!/usr/bin/env fish

# Empty fish greeting (was 02-fish/install.fish).
set -g fish_greeting ""

export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
export PATH="$HOME/.nest/bin:$PATH"

thefuck --alias | source

# uv
fish_add_path "$HOME/.local/bin"

# jenv
status --is-interactive; and jenv init - | source

# Machine-local, untracked overrides (kept out of the dotfiles on purpose).
if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
