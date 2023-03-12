#!/usr/bin/env fish

switch $C_THEME
  case dark
    set -Ux fish_color_autosuggestion 6c7086
    set -Ux fish_color_cancel f38ba8
    set -Ux fish_color_command 89b4fa
    set -Ux fish_color_comment 7f849c
    set -Ux fish_color_cwd f9e2af
    set -Ux fish_color_end fab387
    set -Ux fish_color_error f38ba8
    set -Ux fish_color_escape eba0ac
    set -Ux fish_color_gray 6c7086
    set -Ux fish_color_host 89b4fa
    set -Ux fish_color_host_remote a6e3a1
    set -Ux fish_color_keyword f38ba8
    set -Ux fish_color_normal cdd6f4
    set -Ux fish_color_operator f5c2e7
    set -Ux fish_color_param f2cdcd
    set -Ux fish_color_quote a6e3a1
    set -Ux fish_color_redirection f5c2e7
    set -Ux fish_color_search_match --background=313244
    set -Ux fish_color_selection --background=313244
    set -Ux fish_color_status f38ba8
    set -Ux fish_color_user 94e2d5
    set -Ux fish_pager_color_completion cdd6f4
    set -Ux fish_pager_color_description 6c7086
    set -Ux fish_pager_color_prefix f5c2e7
    set -Ux fish_pager_color_progress 6c7086
  case light
    set -Ux fish_color_autosuggestion 9ca0b0
    set -Ux fish_color_cancel d20f39
    set -Ux fish_color_command 1e66f5
    set -Ux fish_color_comment 8c8fa1
    set -Ux fish_color_cwd df8e1d
    set -Ux fish_color_end fe640b
    set -Ux fish_color_error d20f39
    set -Ux fish_color_escape e64553
    set -Ux fish_color_gray 9ca0b0
    set -Ux fish_color_host 1e66f5
    set -Ux fish_color_host_remote 40a02b
    set -Ux fish_color_keyword d20f39
    set -Ux fish_color_normal 4c4f69
    set -Ux fish_color_operator ea76cb
    set -Ux fish_color_param dd7878
    set -Ux fish_color_quote 40a02b
    set -Ux fish_color_redirection ea76cb
    set -Ux fish_color_search_match --background=ccd0da
    set -Ux fish_color_selection --background=ccd0da
    set -Ux fish_color_status d20f39
    set -Ux fish_color_user 179299
    set -Ux fish_pager_color_completion 4c4f69
    set -Ux fish_pager_color_description 9ca0b0
    set -Ux fish_pager_color_prefix ea76cb
    set -Ux fish_pager_color_progress 9ca0b0
  case "*"
    exit 1
end
