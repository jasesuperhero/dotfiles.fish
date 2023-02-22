#!/usr/bin/env fish

export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

starship init fish | source

function weather --description 'check the weather'
  curl wttr.in/~Berlin;
end

source "$(brew --prefix asdf)"/libexec/asdf.fish

fish_config theme choose "Catppuccin Mocha"

