function gstash -d "browse git stashes with fzf (enter=apply, ctrl-p=pop, ctrl-x=drop)"
    command -q fzf; or return

    set -l preview 'git stash show -p --color=always {1}'
    command -q delta; and set preview "$preview | delta"

    set -l result (
        git stash list |
        fzf --reverse \
            --expect=ctrl-p,ctrl-x \
            --preview "$preview" --preview-window 'right,60%'
    )
    or return

    set -l key $result[1]
    set -l stash (string split ':' -- $result[2])[1]
    test -n "$stash"; or return

    switch $key
        case ctrl-p
            git stash pop $stash
        case ctrl-x
            git stash drop $stash
        case '*'
            git stash apply $stash
    end
end
