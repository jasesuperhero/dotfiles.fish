#!/usr/bin/env fish
# Register fish in /etc/shells and make it the login shell.
# Uses `command -v fish` so it works on macOS (Apple Silicon /opt/homebrew,
# Intel /usr/local) and Ubuntu (/usr/bin) without hard-coded paths.
# Skipped in CI/containers where chsh is unavailable.

if set -q CI; or set -q MISE_SKIP_LOGIN_SHELL
    echo "login-shell: skipped (CI/MISE_SKIP_LOGIN_SHELL set)"
    exit 0
end

set -l fish_path (command -v fish)
test -n "$fish_path"; or exit 0

if not grep -qx "$fish_path" /etc/shells 2>/dev/null
    echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
end

if test "$SHELL" != "$fish_path"
    chsh -s "$fish_path"
end
