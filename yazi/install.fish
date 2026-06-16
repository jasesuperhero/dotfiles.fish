#!/usr/bin/env fish

# Apply the flavor matching the current C_THEME (avoids hardcoding one).
if test -n "$C_THEME"
    "$DOTFILES/yazi/theme.fish"
end
