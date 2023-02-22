#!/usr/bin/env fish

if command -qs gh
    gh config set git_protocol ssh
    gh extension install dlvhdr/gh-dash || true
end
