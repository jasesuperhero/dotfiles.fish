#!/usr/bin/env fish

# atuin's config must be a real dir (not the bootstrap symlink) so theme.fish can
# rewrite the [theme] name on theme switches without dirtying the dotfiles repo.
if test -L $HOME/.config/atuin
    rm $HOME/.config/atuin
end
mkdir -p $HOME/.config/atuin

# Copy config.toml as a real file (force replace).
cp -f $DOTFILES/atuin/config/config.toml $HOME/.config/atuin/config.toml

# Themes don't change at runtime, so a symlink is fine.
if not test -e $HOME/.config/atuin/themes
    ln -sf $DOTFILES/atuin/config/themes $HOME/.config/atuin/themes
end

# Apply the current theme name to the freshly-copied config.
if test -n "$C_THEME"
    "$DOTFILES/atuin/theme.fish"
else
    set -x C_THEME dark
    "$DOTFILES/atuin/theme.fish"
end

# Import existing shell history into atuin on first setup only.
if command -q atuin; and not test -f $HOME/.local/share/atuin/history.db
    atuin import auto
end
