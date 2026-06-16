#!/usr/bin/env fish

# Import existing shell history into atuin on first setup only.
if command -q atuin; and not test -f ~/.local/share/atuin/history.db
    atuin import auto
end
