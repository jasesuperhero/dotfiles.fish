#!/usr/bin/env fish
# One-time adoption: make ~/.dotfiles/mise.toml the GLOBAL mise config so its
# [tools]/[env] are active machine-wide, while preserving any machine/work-
# specific tools in an UNTRACKED ~/.config/mise/config.local.toml (mise loads
# config.local.toml globally alongside config.toml).
#
# Run this ONCE, before your first `mise bootstrap`, then verify with:
#   mise config ls   (should list ~/.config/mise/config.toml -> the repo tools)
#
# It is intentionally NOT part of [tasks.bootstrap] — it changes global state and
# should be a deliberate, reviewed step.

set -l global "$HOME/.config/mise/config.toml"
set -l localcfg "$HOME/.config/mise/config.local.toml"
set -l repo "$HOME/.dotfiles/mise.toml"

mkdir -p "$HOME/.config/mise"

if test -L "$global"
    echo "global config already a symlink -> "(readlink "$global")
else if test -f "$global"
    set -l backup "$global.pre-mise-bootstrap"
    cp "$global" "$backup"
    echo "backed up existing global config -> $backup"
    echo ">> Move any machine/work-specific [tools] from that backup into"
    echo ">> $localcfg (untracked)."
    rm "$global"
    ln -s "$repo" "$global"
    echo "linked $global -> $repo"
else
    ln -s "$repo" "$global"
    echo "linked $global -> $repo"
end

# Seed the untracked local config if absent (carries tools the dotfiles don't own).
if not test -f "$localcfg"
    printf '# Untracked machine/work-specific mise tools — loaded globally by mise,\n# kept out of the tracked dotfiles. Add work tools (bazel, ktlint, ...) here.\n[tools]\ngo = "1.24.5"\n' >"$localcfg"
    mise trust "$localcfg" >/dev/null 2>&1; or true
    echo "seeded $localcfg (edit to add machine-local tools)"
end

mise trust "$repo" >/dev/null 2>&1; or true
echo "done. Now run: cd ~/.dotfiles; mise bootstrap --dry-run"
