#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

set -Ua fish_user_paths /usr/local/sbin
