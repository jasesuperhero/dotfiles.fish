#!/usr/bin/env fish

# Write fzf colors to FZF_DEFAULT_OPTS_FILE instead of a universal variable.
#
# fzf re-reads this file on every invocation, so switching C_THEME updates the
# colors of *every* fzf shortcut (key bindings, git helpers, zoxide, the popup
# wrapper) immediately. A universal `FZF_DEFAULT_OPTS` can't do this: once it's
# exported it gets inherited as a shadowing global in each child process, so the
# `set -Ux` a theme.fish child performs never reliably reaches other shells.
set -l opts_file (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)/fzf/theme.conf
mkdir -p (dirname $opts_file)

switch $C_THEME
    case dark
        printf '%s\n' \
            --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
            --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
            --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 >$opts_file
    case light
        printf '%s\n' \
            --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
            --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
            --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 >$opts_file
    case "*"
        exit 1
end
