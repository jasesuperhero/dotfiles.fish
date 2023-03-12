#!/usr/bin/env fish

if status is-interactive
  set ZELLIJ_AUTO_ATTACH true
  eval (zellij setup --generate-auto-start fish | string collect)
end

if set -q C_THEME
  # update_theme $C_THEME
end
