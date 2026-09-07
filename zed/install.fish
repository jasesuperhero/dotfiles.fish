#!/usr/bin/env fish

# Symlink Zed's settings + keymap from the dotfiles.
#
# settings.json is symlinked, so a pre-existing real file (e.g. one holding a
# GitHub MCP token) is backed up to settings.json.bak rather than lost — grab
# any local secrets from there and re-add them by hand after install.

set -l config_dir "$HOME/.config/zed"

mkdir -p "$config_dir"

for name in settings.json keymap.json tasks.json debug.json
    set -l target "$config_dir/$name"
    set -l source "$DOTFILES/zed/config/$name"

    # Back up a pre-existing real file so local customizations aren't lost.
    if test -e "$target"; and not test -L "$target"
        if not test -e "$target.bak"
            mv "$target" "$target.bak"
        else
            rm "$target"
        end
    end

    ln -sf "$source" "$target"
end
