#!/usr/bin/env fish
# Dispatch OS-specific imperative setup that mise can't express declaratively.

switch (uname)
    case Darwin
        fish "$DOTFILES/tasks/macos-extras.fish"
    case Linux
        fish "$DOTFILES/tasks/linux-extras.fish"
end
