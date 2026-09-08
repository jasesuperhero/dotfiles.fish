#!/usr/bin/env fish

# Prompt/interactive-only: skip in non-interactive shells (scripts, mise tasks,
# theme.fish children) so they don't pay for `starship init`.
if status is-interactive; and command -q starship
    starship init fish | source
end
