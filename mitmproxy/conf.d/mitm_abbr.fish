#!/usr/bin/env fish

if command -qa mitmproxy
    abbr -a mitmon mitm on
    abbr -a mitmoff mitm off
end
