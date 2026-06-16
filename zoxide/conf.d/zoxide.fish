#!/usr/bin/env fish

if command -q zoxide
    zoxide init fish --cmd cd | source
end
