#!/usr/bin/env fish

# Remove old directory symlink if it exists (from bootstrap)
if test -L $HOME/.config/zellij
    rm $HOME/.config/zellij
end

mkdir -p $HOME/.config/zellij

# Copy config template as a real file (force replace)
cp -f $DOTFILES/zellij/config/config.kdl $HOME/.config/zellij/config.kdl

# Symlink subdirectories
for dir in themes layouts
    if not test -e $HOME/.config/zellij/$dir
        ln -sf $DOTFILES/zellij/config/$dir $HOME/.config/zellij/$dir
    end
end
