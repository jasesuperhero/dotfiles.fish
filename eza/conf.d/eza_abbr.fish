#!/usr/bin/env fish

if command -qa eza
    abbr -a ls eza
    abbr -a lg 'eza --git'
    abbr -a l 'eza -lah'
    abbr -a la 'eza -a'
    abbr -a ll 'eza -l'
    abbr -a lt 'eza -lT'
else
    abbr -a l 'ls -lAh'
    abbr -a la 'ls -A'
    abbr -a ll 'ls -l'
end
