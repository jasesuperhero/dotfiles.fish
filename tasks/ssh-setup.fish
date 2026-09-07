#!/usr/bin/env fish
# Ensure ~/.ssh/config includes the tracked config.dotfiles and has safe perms.
# Never overwrites the user's ~/.ssh/config (may hold machine-specific hosts).

test -d ~/.ssh; or mkdir -p ~/.ssh
chmod 700 ~/.ssh
test -f ~/.ssh/config; or touch ~/.ssh/config

grep -q "Include ~/.ssh/config.dotfiles" ~/.ssh/config
or echo "Include ~/.ssh/config.dotfiles" >>~/.ssh/config
chmod 600 ~/.ssh/config

# macOS: keychain-backed keys.
switch (uname)
    case Darwin
        grep -q "UseKeychain yes" ~/.ssh/config
        or printf '\nHost *\n  UseKeychain yes\n' >>~/.ssh/config
end
