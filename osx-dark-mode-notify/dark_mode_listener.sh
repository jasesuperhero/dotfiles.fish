#!/bin/sh
# dark-notify runs this with "dark"/"light" on every macOS appearance change.
#
# Deliberately minimal POSIX sh: it runs in launchd's restricted context (no
# Homebrew on PATH, so no fish; no $DOTFILES; no autoloaded functions). It only
# records the desired theme in ~/.theme. Interactive fish shells apply it on
# their next prompt (or at startup) — see 02-fish/conf.d/apply_theme.fish — which
# is where the full environment (fish, $DOTFILES, the theme scripts) exists.
echo "$1" >"$HOME/.theme"
