#!/usr/bin/env fish

function cap --description "Quick-capture a timestamped bullet into today's Obsidian daily note"
    set -l vault ~/Documents/notes
    set -l day (date +%Y-%m-%d)
    set -l file $vault/daily/$day.md

    if not set -q argv[1]
        echo "cap: nothing to capture — usage: cap <text>" >&2
        return 1
    end
    set -l text (string join ' ' -- $argv)

    # Seed obsidian.nvim's daily-note frontmatter when the file doesn't exist
    # yet, so `notes` (which opens the same file) sees a well-formed note.
    if not test -f $file
        mkdir -p (dirname $file)
        printf '---\nid: "%s"\naliases: []\ntags:\n  - daily-notes\n---\n\n' $day >$file
    end

    printf '- %s %s\n' (date +%H:%M) "$text" >>$file
    echo "cap → daily/$day.md"
end
