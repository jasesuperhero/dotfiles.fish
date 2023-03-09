#!/usr/bin/env fish

if command -qs gh
    gh extension install dlvhdr/gh-dash || true
end
