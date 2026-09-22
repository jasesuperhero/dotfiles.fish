#!/usr/bin/env fish

set -l theme (theme_pick dark light); or exit 1

# Claude Code creates this file on first launch. Do not create or replace its
# user-owned settings when Claude Code has not been run yet.
test -f "$HOME/.claude.json"; or exit 0

_sed_inplace "s/\"theme\": \"[^\"]*\"/\"theme\": \"$theme\"/" "$HOME/.claude.json"
