#!/usr/bin/env fish

# Remove old directory symlink if it exists (from bootstrap)
if test -L $HOME/.config/zellij
    rm $HOME/.config/zellij
end

mkdir -p $HOME/.config/zellij

# Copy config template as a real file (force replace)
cp -f $DOTFILES/zellij/config/config.kdl $HOME/.config/zellij/config.kdl

# Symlink themes directory
if not test -e $HOME/.config/zellij/themes
    ln -sf $DOTFILES/zellij/config/themes $HOME/.config/zellij/themes
end

# Replace layouts symlink with a real directory
if test -L $HOME/.config/zellij/layouts
    rm $HOME/.config/zellij/layouts
end
mkdir -p $HOME/.config/zellij/layouts

# Copy scripts and make them executable
mkdir -p $HOME/.config/zellij/scripts
cp -f $DOTFILES/zellij/scripts/*.sh $HOME/.config/zellij/scripts/
chmod +x $HOME/.config/zellij/scripts/*.sh

# Apply current theme (copies layout file and substitutes scripts path)
if test -n "$C_THEME"
    "$DOTFILES/zellij/theme.fish"
else
    # Fallback to dark if C_THEME not set
    set -x C_THEME dark
    "$DOTFILES/zellij/theme.fish"
end
