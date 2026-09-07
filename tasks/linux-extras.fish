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
    set -l ver (curl -sf "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" \
        | string match -r '"tag_name": *"([^"]+)"' | tail -1 | string trim -c '"')
    if test -n "$ver"
        curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/$ver/JetBrainsMono.tar.xz" \
            -o /tmp/JetBrainsMono.tar.xz
        and mkdir -p "$fonts_dir"
        and tar xf /tmp/JetBrainsMono.tar.xz -C "$fonts_dir"
        and fc-cache -f "$fonts_dir"
        rm -f /tmp/JetBrainsMono.tar.xz
    else
        echo "linux-extras: could not resolve Nerd Font version (offline?); skipping"
    end
end
