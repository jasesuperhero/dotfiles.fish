function ghelp -d "cheatsheet for the git helper functions and abbreviations"
    set -l dir $DOTFILES/git/functions

    set_color --bold brgreen
    echo "git helper functions"
    set_color normal

    for file in $dir/*.fish
        set -l fn (basename $file .fish)
        test $fn = ghelp; and continue
        # Pull the description straight from each function's `-d "..."` so this
        # list never drifts from the actual definitions.
        set -l desc (string match -rg ' -d "(.+)"' -- (head -1 $file))
        printf "  "
        set_color --bold cyan
        printf "%-10s" $fn
        set_color normal
        printf " %s\n" "$desc"
    end

    echo
    set_color --bold brgreen
    echo abbreviations
    set_color normal
    printf "  "
    set_color --bold cyan
    printf "%-10s" g
    set_color normal
    printf " %s\n" git

    echo
    set_color brblack
    echo "tip: run 'git aliases' to list the aliases defined in your gitconfig"
    set_color normal
end
