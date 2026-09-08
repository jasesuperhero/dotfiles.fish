function e -d "edit folders with $EDITOR"
    set -l f $argv[1]
    if test -z "$f"
        set f .
    end
    $EDITOR "$f"
end
