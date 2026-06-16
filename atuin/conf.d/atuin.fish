#!/usr/bin/env fish

if command -q atuin
    # --disable-up-arrow keeps fish's native Up-arrow history; Ctrl-R opens atuin.
    atuin init fish --disable-up-arrow | source

    # The jethrokuan/fzf plugin (conf.d/fzf.fish) also binds Ctrl-R and, sorting
    # after atuin.fish, would otherwise win. Reclaim Ctrl-R for atuin once, after
    # all conf.d have loaded, while leaving fzf's other bindings (Ctrl-T, Alt-C…)
    # intact.
    function _atuin_claim_ctrl_r --on-event fish_prompt
        bind \cr _atuin_search
        bind -M insert \cr _atuin_search 2>/dev/null
        functions -e _atuin_claim_ctrl_r
    end
end
