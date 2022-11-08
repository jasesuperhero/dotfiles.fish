#!/usr/bin/env fish

export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

starship init fish | source
# mcfly init fish | source
source "$(brew --prefix asdf)"/libexec/asdf.fish
