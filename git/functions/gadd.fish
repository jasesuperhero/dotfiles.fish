function gadd -d "interactively stage changed/untracked files with fzf (Tab to multi-select)"
    command -q fzf; or return

    set -l preview '
        f=$(printf %s {} | cut -c4-)
        if git ls-files --error-unmatch "$f" >/dev/null 2>&1
            git diff --color=always -- "$f"
        else
            command -v bat >/dev/null && bat --style=plain --color=always "$f" 2>/dev/null || cat "$f"
        fi'

    set -l lines (
        git status --short --no-renames |
        string match -rv '^##' | # drop branch header (status.branch users)
        string match -rv '^[MADRC] ' | # drop entries with nothing left to stage
        fzf -m --reverse \
            --preview "$preview" --preview-window 'right,60%'
    )
    or return

    set -l files
    for line in $lines
        set -a files (string sub -s 4 -- $line)
    end
    test (count $files) -gt 0; or return
    git add -- $files
    git status --short
end
