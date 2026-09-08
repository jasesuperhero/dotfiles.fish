#!/usr/bin/env fish
# Compatibility wrapper — provisioning is now `mise bootstrap` (see mise.toml).
#
# First time on a machine? Make the repo the global mise config first:
#   sh ~/.dotfiles/tasks/adopt-global-config.sh
# Then this wrapper (or `mise bootstrap` directly) provisions everything.

if not command -q mise
    echo "mise is not installed. Install it first: https://mise.run" >&2
    echo "  curl https://mise.run | sh" >&2
    exit 1
end

cd (dirname (status --current-filename))/..
exec mise bootstrap $argv
