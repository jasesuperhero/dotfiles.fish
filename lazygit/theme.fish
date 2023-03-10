#!/usr/bin/env fish

switch $C_THEME
  case dark
  case light
  case "*"
    exit 1
end
