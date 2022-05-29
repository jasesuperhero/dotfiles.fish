#!/usr/bin/env fish

set XCODE_THEMES_PATH ~/Library/Developer/Xcode/UserData/FontAndColorThemes

if not test -d $XCODE_THEMES_PATH
  echo "Create XCODE_THEMES_PATH directory at $XCODE_THEMES_PATH"
  mkdir "$XCODE_THEMES_PATH"
end

ln -sf \
  "$DOTFILES/xcode/Dracula (Dark).xccolortheme" \
  "$XCODE_THEMES_PATH/Dracula (Dark).xccolortheme" 
