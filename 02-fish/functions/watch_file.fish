#!/usr/bin/env fish

function watch_file
    fswatch $argv[1] | while read
        eval $argv[2..-1]
    end
end
