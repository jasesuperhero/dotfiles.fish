#!/usr/bin/env fish

export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

starship init fish | source
mcfly init fish | source
source /usr/local/opt/asdf/libexec/asdf.fish
