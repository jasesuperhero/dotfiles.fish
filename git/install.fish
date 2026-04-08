#!/usr/bin/env fish

if test (uname) = Darwin
    git config --global credential.helper osxkeychain
end
