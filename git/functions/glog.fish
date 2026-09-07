function glog -d "browse git log with fzf and a delta diff preview"
    command -q fzf; or return

    # The preview runs under sh (not fish), so it can't see the `delta` alias or
    # $C_THEME. Resolve the theme-aware delta feature here and bake it in so the
    # diff colors match the current theme, mirroring core.pager in gitconfig.
    set -l preview 'git show --color=always {1}'
    if command -q delta
        set -l mode (test "$C_THEME" = dark; and echo dark-mode; or echo light-mode)
        set preview "git show {1} | delta --features $mode"
    end

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
