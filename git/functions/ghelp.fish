function ghelp -d "cheatsheet: git helper functions, git-* subcommands, and gitconfig aliases"
    # --- fish helper functions (git/functions/*.fish) ---
    set_color --bold brgreen
    echo "git helper functions"
    set_color normal
    for file in $DOTFILES/git/functions/*.fish
        set -l fn (basename $file .fish)
        test $fn = ghelp; and continue
        # Pull the description straight from each function's `-d "..."` so this
        # list never drifts from the actual definitions.
        set -l desc (string match -rg ' -d "(.+)"' -- (head -1 $file))
        printf "  "
        set_color --bold cyan
        printf "%-22s" $fn
        set_color normal
        printf " %s\n" "$desc"
    end

    # --- git-* subcommands from bin/ (run as `git <sub>`) ---
    echo
    set_color --bold brgreen
    echo "git-* subcommands (bin/)"
    set_color normal
    for file in $DOTFILES/bin/git-*
        test -f "$file"; or continue
        set -l sub (string replace git- 'git ' (basename "$file"))
        # First real comment line (skips the shebang) as a best-effort description.
        set -l desc (grep -m1 -E '^# .' -- "$file" | string replace -r '^# *' '')
        printf "  "
        set_color --bold cyan
        printf "%-22s" $sub
        set_color normal
        printf " %s\n" "$desc"
    end

    # --- gitconfig aliases (from ~/.gitconfig include -> git/gitconfig) ---
    echo
    set_color --bold brgreen
    echo "gitconfig aliases (git <alias>)"
    set_color normal
    for line in (git config --get-regexp '^alias\.' 2>/dev/null)
        set -l parts (string split -m1 ' ' -- $line)
        set -l name (string replace alias. '' -- $parts[1])
        printf "  "
        set_color --bold cyan
        printf "%-22s" $name
        set_color normal
        # Truncate long alias bodies so the list stays scannable.
        printf " %s\n" (string sub -l 64 -- "$parts[2]")
    end

    # --- abbreviations ---
    echo
    set_color --bold brgreen
    echo abbreviations
    set_color normal
    printf "  "
    set_color --bold cyan
    printf "%-22s" g
    set_color normal
    printf " %s\n" git
end
