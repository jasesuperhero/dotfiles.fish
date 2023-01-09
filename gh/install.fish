#!/usr/bin/env fish

if command -qs gh
    gh config set git_protocol ssh
    gh auth login
    gh extension install dlvhdr/gh-dash
end
