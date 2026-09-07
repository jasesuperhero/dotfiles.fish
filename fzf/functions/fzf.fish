function fzf -d "fzf with popup mode"
    # Shared UI, mirroring zoxide's `cdi` look: reverse layout, inline info
    # line, sharp borders, keep long lines right-aligned, wrap-around, and a
    # bottom preview pane. Listed before $argv so a command can still override
    # any of them (e.g. the git helpers set their own --preview-window).
    command fzf --popup center,80%,80% \
        --layout=reverse --info=inline --border=sharp \
        --keep-right --cycle --tabstop=1 \
        --preview-window=down,30%,sharp \
        $argv
end
