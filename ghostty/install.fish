#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

set -l target "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
set -l source "$DOTFILES/ghostty/config/config"

mkdir -p (dirname "$target")

# Back up any pre-existing real file (e.g. ghostty's auto-generated template)
# so customizations aren't silently lost on first install.
if test -e "$target"; and not test -L "$target"
    if not test -e "$target.bak"
        mv "$target" "$target.bak"
    else
        rm "$target"
    end
end

ln -sf "$source" "$target"
