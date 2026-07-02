function gunstage -d "interactively unstage files with fzf (Tab to multi-select)"
    command -q fzf; or return

    set -l preview 'git diff --cached --color=always -- {}'
    command -q delta; and set preview "$preview | delta"

    set -l files (
        git diff --cached --name-only |
        fzf -m --reverse \
            --preview "$preview" --preview-window 'right,60%'
    )
    or return

    test (count $files) -gt 0; or return
    git restore --staged -- $files
    git status --short
end
