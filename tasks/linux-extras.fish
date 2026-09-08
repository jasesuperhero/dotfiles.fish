#!/usr/bin/env fish
# Ubuntu/Debian imperative exceptions.
#
# Everything the old linux/install.fish downloaded from GitHub (neovim, delta,
# eza, dust, lazygit, lazydocker, k9s, kubectx/kubens, zellij, shfmt, prek, viu,
# atuin, tealdeer, starship) is now a portable mise [tools] entry, and the
# GitHub-CLI apt repo is gone (gh is a mise tool). The only surviving download is
# the Nerd Font, which has no reliable declarative cross-distro mechanism.

test (uname) = Linux; or exit 0

set -l fonts_dir ~/.local/share/fonts

# JetBrainsMono Nerd Font — user install, no root. The archive is arch-agnostic.
if not test -f "$fonts_dir/JetBrainsMonoNerdFont-Regular.ttf"
    # Authenticate the API call when a token is present (avoids the 60 req/hr
    # unauthenticated GitHub rate limit, e.g. in CI).
    set -l auth
    test -n "$GITHUB_TOKEN"; and set auth -H "Authorization: Bearer $GITHUB_TOKEN"

    set -l ver (curl -sf $auth "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" \
        | string match -r '"tag_name": *"([^"]+)"' | tail -1 | string trim -c '"')
    if test -n "$ver"
        # Unique temp path (avoid a shared /tmp collision between concurrent runs).
        set -l tmp (mktemp -t JetBrainsMono.XXXXXX)
        curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/$ver/JetBrainsMono.tar.xz" -o "$tmp"
        and mkdir -p "$fonts_dir"
        and tar xf "$tmp" -C "$fonts_dir"
        and fc-cache -f "$fonts_dir"
        rm -f "$tmp"
    else
        echo "linux-extras: could not resolve Nerd Font version (offline/rate-limited?); skipping"
    end
end
