#!/usr/bin/env fish

if command -qa brew and status is-interactive
  set ZELLIJ_AUTO_ATTACH true
  eval (zellij setup --generate-auto-start fish | string collect)
end
