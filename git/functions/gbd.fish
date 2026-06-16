function gbd -d "fuzzy-delete local git branches (Tab to multi-select)"
    command -q fzf; or return

    set -l branches (
        git branch --format='%(refname:short)' |
        string match -v (git branch --show-current) |
        fzf -m --reverse --height 50% \
            --preview 'git log --oneline --graph --color=always -n 30 {}'
    )
    or return

    test (count $branches) -gt 0; or return
    if not git branch -d $branches
        echo "Some branches are not fully merged. Re-run and use 'git branch -D' to force." >&2
    end
end
