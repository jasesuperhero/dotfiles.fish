#!/usr/bin/env fish

set -l theme (theme_pick dark light); or exit 1

_sed_inplace "s/\"theme\": \"[^\"]*\"/\"theme\": \"$theme\"/" "$HOME/.claude.json"
