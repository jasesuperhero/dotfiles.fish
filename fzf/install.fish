#!/usr/bin/env fish

# Apply theme colors based on current C_THEME (avoids hardcoding a specific theme)
if test -n "$C_THEME"
    "$DOTFILES/fzf/theme.fish"
end
