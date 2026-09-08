#!/usr/bin/env fish

# Empty fish greeting (was 02-fish/install.fish).
set -g fish_greeting ""

# thefuck: interactive-only, and skip cleanly when it isn't installed so a
# freshly-bootstrapped machine (thefuck is not managed by mise) has a quiet shell.
if status is-interactive; and command -q thefuck
    thefuck --alias | source
end

# uv
fish_add_path "$HOME/.local/bin"

# jenv (interactive-only; skip if absent)
status is-interactive; and command -q jenv; and jenv init - | source

# Machine-local, untracked overrides (kept out of the dotfiles on purpose).
# Machine-specific PATHs (e.g. mojo/Modular, ~/.nest/bin) live here now, not in
# this tracked file — add them to ~/.localrc.fish with fish_add_path.
if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
