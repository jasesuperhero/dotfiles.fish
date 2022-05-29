#!/usr/bin/env fish

set XCODE_THEMES_PATH "~/Library/Developer/Xcode/UserData/FontAndColorThemes"

mkdir -p "$XCODE_THEMES_PATH"
ln -sf \
  "$DOTFILES/xcode/Dracula (Dark).xccolortheme" \
  "$XCODE_THEMES_PATH/Dracula (Dark).xccolortheme" 
