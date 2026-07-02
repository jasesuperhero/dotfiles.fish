function glog -d "browse git log with fzf and a delta diff preview"
    command -q fzf; or return

    set -l preview 'git show --color=always {1}'
    command -q delta; and set preview "$preview | delta"

    set -l result (
        git log --color=always --format='%h %C(auto)%s %C(dim)%cr %an' $argv |
        fzf --ansi --no-sort --reverse \
            --expect=ctrl-y \
            --preview "$preview" --preview-window 'right,60%'
    )
    or return

    set -l key $result[1]
    set -l hash (string split ' ' -- $result[2])[1]
    test -n "$hash"; or return

    if test "$key" = ctrl-y
        echo -n $hash | fish_clipboard_copy
        echo "copied $hash"
    else
        git show $hash
    end
end
