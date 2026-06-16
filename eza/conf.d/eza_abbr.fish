#!/usr/bin/env fish

if command -qa eza
    abbr -a ls 'eza --icons'
    abbr -a lg 'eza --icons --git'
    abbr -a l 'eza -lah --icons --git'
    abbr -a la 'eza -la --icons --git'
    abbr -a ll 'eza -lah --icons --git'
    abbr -a lt 'eza -lT --icons --git'
else
    abbr -a l 'ls -lAh'
    abbr -a la 'ls -A'
    abbr -a ll 'ls -l'
end
