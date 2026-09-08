#!/usr/bin/env fish

# Interactive-only: non-interactive shells (scripts, theme.fish children) keep
# fish's builtin `cd` and don't pay for `zoxide init`.
if status is-interactive; and command -q zoxide
    zoxide init fish --cmd cd | source

    # Override zoxide's built-in `cdi` (inline 45%-height fzf) so it uses our
    # shared fzf popup UI instead — see fzf/functions/fzf.fish. Directories are
    # still listed by zoxide frecency; `cd` (aliased to zoxide) bumps the score.
    function cdi -d "interactive cd via zoxide, using the shared fzf popup UI"
        set -l dir (zoxide query --list | fzf --preview 'ls -Cp {}')
        and cd $dir
    end
end
