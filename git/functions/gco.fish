function gco -d "git checkout local or remote branch with fzf"
    command -q fzf; or return

    set -l branch (
        git for-each-ref --sort=-committerdate \
            --format='%(refname:short)' refs/heads refs/remotes |
        string match -v 'origin/HEAD' |
        fzf --reverse \
            --preview 'git log --oneline --graph --color=always -n 30 {}'
    )
    or return

    if git show-ref --verify --quiet "refs/heads/$branch"
        # Local branch — check it out directly (handles names with slashes).
        git checkout $branch
    else
        # Remote-tracking pick like "origin/eng/foo": drop the remote name and let
        # git's DWIM create/switch the matching local branch, same as `git co eng/foo`.
        git checkout (string replace -r '^[^/]+/' '' -- $branch)
    end
end
