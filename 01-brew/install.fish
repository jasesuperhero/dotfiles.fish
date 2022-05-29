#!/usr/bin/env fish

# Install homebrew if doesn't exist
if not command -qa brew
  /bin/bash -c "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew analytics off
end

brew bundle \
  --file "$DOTFILES/01-brew/Brewfile" \
  --no-lock \
  --quiet
