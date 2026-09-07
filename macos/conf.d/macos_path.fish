#!/usr/bin/env fish
# macOS: keep /usr/local/sbin on PATH (was macos/install.fish).
if test (uname) = Darwin
    fish_add_path -g /usr/local/sbin
end
