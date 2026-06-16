function gco -d "git checkout local or remote branch with fzf"
    command -q fzf; or return

    set -l branch (
        git for-each-ref --sort=-committerdate \
            --format='%(refname:short)' refs/heads refs/remotes |
        string match -v 'origin/HEAD' |
        fzf --reverse --height 40% \
            --preview 'git log --oneline --graph --color=always -n 30 {}'
    )
    or return

    # Remote pick like "origin/feature" -> switch to a tracking "feature"
    set -l local (string replace -r '^[^/]+/' '' -- $branch)
    if git show-ref --verify --quiet "refs/heads/$local"
        git switch $local
    else if test "$local" != "$branch"
        git switch -c $local --track $branch
    else
        git switch $branch
    end
end
