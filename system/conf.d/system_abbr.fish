#!/usr/bin/env fish

# -R passes ANSI color escapes through literally; -r emits raw control bytes and
# can mangle output.
abbr -a less 'less -R'

# Harpoon-style picker for all Claude Code sessions (status/cwd/jump).
abbr -a ccs claude-sessions
