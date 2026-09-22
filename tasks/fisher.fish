#!/usr/bin/env fish
# Install fisher if absent, then converge the tracked plugin set.
# Installs each missing plugin individually; an incomplete setup is reported as
# a bootstrap failure. Already-installed plugins are skipped on re-runs.

if not functions -q fisher
    curl -sfL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher install jorgebucaran/fisher
end
if not functions -q fisher
    echo "fisher: installation failed" >&2
    exit 1
end

set -l plugins_file "$DOTFILES/03-fisher/plugins"
test -f "$plugins_file"; or exit 0

set -l installed (fisher list 2>/dev/null); or exit 1
set -l failed
for p in (cat "$plugins_file")
    set -l name (string split '@' -- $p)[1]
    contains -- $name $installed; and continue
    if not fisher install $p
        echo "fisher: WARNING — could not install '$p' (skipping)" >&2
        set -a failed $p
    end
end

set -q failed[1]; and echo "fisher: "(count $failed)" plugin(s) failed: $failed" >&2
test (count $failed) -eq 0
