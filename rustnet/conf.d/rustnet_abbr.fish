#!/usr/bin/env fish

if command -qa rustnet
    # rustnet needs elevated privileges for packet capture
    abbr -a net 'sudo rustnet'
end
