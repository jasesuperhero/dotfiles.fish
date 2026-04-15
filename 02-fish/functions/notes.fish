#!/usr/bin/env fish

function notes --description "Open Obsidian vault in a Zellij floating pane at today's daily note"
    zellij action new-pane --floating --cwd ~/Documents/notes -- nvim daily/(date +%Y-%m-%d).md
end
