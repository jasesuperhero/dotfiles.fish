#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

# Install homebrew if doesn't exist
if not command -qa brew
    /bin/bash -c "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew analytics off
end

# Install gum early so subsequent install.fish steps can use spinners
if not type -q gum
    brew install gum --quiet
end

brew bundle \
    --file "$DOTFILES/01-brew/Brewfile" \
    --no-upgrade \
    --quiet
