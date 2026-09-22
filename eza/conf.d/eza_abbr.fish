#!/usr/bin/env fish

if command -qa eza
    abbr -a ls eza
    abbr -a lg 'eza --git'
    abbr -a l 'eza -lah --git'
    abbr -a la 'eza -la --git'
    abbr -a ll 'eza -lah --git'
    abbr -a lt 'eza -lT --git'
else
    abbr -a l 'ls -lAh'
    abbr -a la 'ls -A'
    abbr -a ll 'ls -l'
end
