#!/usr/bin/env fish
# macOS: put Homebrew's bin/sbin on PATH (arch-aware).
# On Apple Silicon /opt/homebrew is NOT in /etc/paths, and tools installed by
# `mise bootstrap` (mise, git-lfs, tmux, …) live under the brew prefix — the shell
# must find them without relying on the fisher fish-brew plugin having run first.
# fish_add_path dedupes, so this is safe to run on every shell.
if test (uname) = Darwin
    if test -x /opt/homebrew/bin/brew
        fish_add_path -g /opt/homebrew/bin /opt/homebrew/sbin
    end
    fish_add_path -g /usr/local/sbin
end
