#!/usr/local/bin/fish

switch $DARKMODE
  case 1
    update_theme dark
  case 0
    update_theme light
end
