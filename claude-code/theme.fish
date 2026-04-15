#!/usr/bin/env fish

switch $C_THEME
    case dark
        sed -i '' 's/"theme": "[^"]*"/"theme": "dark"/' "$HOME/.claude.json"
    case light
        sed -i '' 's/"theme": "[^"]*"/"theme": "light"/' "$HOME/.claude.json"
    case "*"
        exit 1
end
