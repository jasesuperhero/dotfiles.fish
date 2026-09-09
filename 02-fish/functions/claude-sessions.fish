function claude-sessions -d "harpoon-style picker for Claude Code sessions (enter=jump, ctrl-x=forget)"
    command -q fzf; or return
    command -q zellij; or begin
        echo "claude-sessions: zellij not found"
        return 1
    end

    set -l dir (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/claude-sessions
    if not test -d $dir
        echo "No Claude sessions tracked yet."
        return
    end

    # Live (non-EXITED) session names — for filtering + pruning stale state files.
    set -l live (zellij list-sessions --no-formatting 2>/dev/null | grep -v EXITED | awk '{print $1}')
    set -l now (date +%s)

    # Bucket by status so waiting (most urgent) sorts first, then running, then done.
    set -l waiting
    set -l running
    set -l finished

    for f in $dir/*
        test -f "$f"; or continue
        set -l session (_cs_field "$f" session)
        set -l pane (_cs_field "$f" pane_id)
        test -n "$session" -a -n "$pane"; or continue

        # Prune state files whose session is gone/EXITED.
        if test (count $live) -gt 0; and not contains -- $session $live
            rm -f "$f"
            continue
        end

        set -l status (_cs_field "$f" status)
        set -l tab (_cs_field "$f" tab)
        set -l cwd (_cs_field "$f" cwd)
        set -l epoch (_cs_field "$f" epoch)
        test -n "$tab"; or set tab "—"

        set -l icon ·
        switch $status
            case waiting
                set icon ●
            case running
                set icon ▶
            case done
                set icon ✻
        end

        set -l dcwd (string replace -r "^$HOME" '~' -- "$cwd")
        set -l row (printf '%s\t%s\t%s\t%s  %s · %s · %s  (%s)' \
            "$f" "$session" "$pane" "$icon" "$session" "$tab" "$dcwd" (_cs_age "$epoch" "$now"))

        switch $status
            case waiting
                set -a waiting $row
            case running
                set -a running $row
            case '*'
                set -a finished $row
        end
    end

    set -l rows $waiting $running $finished
    if test (count $rows) -eq 0
        echo "No live Claude sessions."
        return
    end

    set -l result (
        printf '%s\n' $rows |
        fzf --delimiter '\t' --with-nth 4.. \
            --expect=ctrl-x \
            --prompt 'claude ❯ ' \
            --preview "$DOTFILES/claude-code/claude-session-preview.sh {1}" \
            --preview-window 'right,55%,sharp'
    )
    or return

    set -l key $result[1]
    test -n "$result[2]"; or return
    set -l parts (string split \t -- $result[2])
    set -l file $parts[1]
    set -l session $parts[2]
    set -l pane $parts[3]

    switch $key
        case ctrl-x
            rm -f "$file"
            claude-sessions # reopen, refreshed
        case '*'
            if test "$session" = "$ZELLIJ_SESSION_NAME"
                zellij action focus-pane-id $pane
            else
                zellij action switch-session $session --pane-id terminal_$pane
            end
            command -q open; and open -b com.mitchellh.ghostty 2>/dev/null
    end
end

# --- helpers (loaded with this file; only used by claude-sessions) ---

function _cs_field -a file key -d "read a key=value field from a claude-sessions state file"
    set -l line (grep -m1 "^$key=" -- "$file" 2>/dev/null)
    string replace -r "^$key=" '' -- "$line"
end

function _cs_age -a epoch now -d "compact relative age for a unix timestamp"
    string match -qr '^\d+$' -- "$epoch"; or begin
        echo "?"
        return
    end
    set -l d (math "$now - $epoch")
    if test $d -lt 60
        echo {$d}s
    else if test $d -lt 3600
        echo (math -s0 $d / 60)m
    else if test $d -lt 86400
        echo (math -s0 $d / 3600)h
    else
        echo (math -s0 $d / 86400)d
    end
end
