#!/bin/sh
set -eu
# One-time adoption: make ~/.dotfiles/mise.toml the GLOBAL mise config so its
# [tools]/[env] are active machine-wide, while preserving any machine/work-
# specific tools in an UNTRACKED ~/.config/mise/config.local.toml (mise loads
# config.local.toml globally alongside config.toml).
#
# POSIX sh (not fish) on purpose: on a fresh machine this runs BEFORE
# `mise bootstrap` installs fish, so it must not depend on fish being present.
#
# Run this ONCE, before your first `mise bootstrap`, then verify with:
#   mise config ls   (should list ~/.config/mise/config.toml -> the repo tools)
#
# It is intentionally NOT part of [tasks.bootstrap] — it changes global state and
# should be a deliberate, reviewed step.

global="$HOME/.config/mise/config.toml"
localcfg="$HOME/.config/mise/config.local.toml"
repo="$HOME/.dotfiles/mise.toml"

mkdir -p "$HOME/.config/mise"
[ -f "$repo" ] || {
    echo "missing repo config: $repo" >&2
    exit 1
}

if [ -L "$global" ]; then
    if [ "$(readlink "$global")" != "$repo" ]; then
        echo "global config points elsewhere: $global -> $(readlink "$global")" >&2
        exit 1
    fi
    echo "global config already a symlink -> $repo"
elif [ -f "$global" ]; then
    backup="$global.pre-mise-bootstrap"
    # A stale backup must never hide changes made to the current config.
    if [ -e "$backup" ] || [ -L "$backup" ]; then
        if ! cmp -s "$global" "$backup"; then
            echo "existing backup differs from $global; reconcile them before adopting" >&2
            exit 1
        fi
    else
        cp -p "$global" "$backup"
    fi
    echo "backed up existing global config -> $backup"
    echo ">> Move any machine/work-specific [tools] from that backup into"
    echo ">> $localcfg (untracked)."
    # Prepare the link first, then replace the backed-up file atomically.
    pending="$global.pending.$$"
    trap 'rm -f "$pending"' EXIT HUP INT TERM
    ln -s "$repo" "$pending"
    mv -f "$pending" "$global"
    trap - EXIT HUP INT TERM
    echo "linked $global -> $repo"
else
    if [ -e "$global" ]; then
        echo "global config exists but is not a regular file: $global" >&2
        exit 1
    fi
    ln -s "$repo" "$global"
    echo "linked $global -> $repo"
fi

# Seed the untracked local config if absent (carries tools the dotfiles don't own).
if [ ! -f "$localcfg" ]; then
    printf '# Untracked machine/work-specific mise tools — loaded globally by mise,\n# kept out of the tracked dotfiles. Add work tools (bazel, ktlint, ...) here.\n[tools]\ngo = "latest"\n' >"$localcfg"
    mise trust "$localcfg" >/dev/null 2>&1 || true
    echo "seeded $localcfg (edit to add machine-local tools)"
fi

mise trust "$repo" >/dev/null 2>&1 || true
echo "done. Now run: cd ~/.dotfiles; mise bootstrap --dry-run"
