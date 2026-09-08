#!/usr/bin/env fish

# EDITOR/VISUAL are set in mise.toml [env] (machine-wide), not here.

# `e` is a smarter function (system/functions/e.fish): it opens $EDITOR on the
# given path, defaulting to the current dir. v/vi/vim go straight to nvim.
abbr -a v nvim
abbr -a vi nvim
abbr -a vim nvim
