#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

abbr -a ksim 'killall -9 "com.apple.CoreSimulator.CoreSimulatorService"'
