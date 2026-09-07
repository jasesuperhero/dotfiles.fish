#!/usr/bin/env fish
# Install fisher if absent, then converge the tracked plugin set.
# Idempotent: the remote installer is fetched only when fisher is missing, and
# already-present plugins are skipped so re-runs work offline.

if not functions -q fisher
    curl -sfL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher install jorgebucaran/fisher
end

set -l plugins_file "$DOTFILES/03-fisher/plugins"
test -f "$plugins_file"; or exit 0

set -l installed (fisher list 2>/dev/null)
set -l missing
for p in (cat "$plugins_file")
    set -l name (string split '@' -- $p)[1]
    contains -- $name $installed; or set -a missing $p
end

if set -q missing[1]
    fisher install $missing
else
    echo "fisher: all tracked plugins already installed"
end
