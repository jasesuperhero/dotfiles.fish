#!/usr/bin/env fish

# Tell fzf to read default options (currently just theme colors) from a file
# that `fzf/theme.fish` rewrites on every C_THEME change. The env var's value
# never changes — only the file's contents do — so this can safely be exported
# once and dynamic themes still work. See fzf/theme.fish for the why.
set -gx FZF_DEFAULT_OPTS_FILE (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)/fzf/theme.conf
