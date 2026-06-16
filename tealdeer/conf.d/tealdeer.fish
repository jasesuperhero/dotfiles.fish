#!/usr/bin/env fish

# Look for config.toml in ~/.config/tealdeer on every platform (macOS otherwise
# defaults to ~/Library/Application Support). bootstrap symlinks it there.
set -gx TEALDEER_CONFIG_DIR $HOME/.config/tealdeer
