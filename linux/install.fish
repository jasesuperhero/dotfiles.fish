#!/usr/bin/env fish

if test (uname) != Linux
    exit
end

# ── helpers ──────────────────────────────────────────────────────────────────

function _latest_gh_release -a repo
    curl -sf "https://api.github.com/repos/$repo/releases/latest" \
        | string match -r '"tag_name": *"([^"]+)"' \
        | tail -1 \
        | string trim -c '"'
end

function _arch
    switch (uname -m)
        case x86_64
            echo amd64
        case aarch64 arm64
            echo arm64
    end
end

function _arch_musl
    switch (uname -m)
        case x86_64
            echo x86_64
        case aarch64 arm64
            echo aarch64
    end
end

mkdir -p ~/.local/bin

# ── GitHub CLI apt repo ───────────────────────────────────────────────────────

if not test -f /etc/apt/sources.list.d/github-cli.list
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        | sudo tee /etc/apt/sources.list.d/github-cli.list
end

# ── apt packages ─────────────────────────────────────────────────────────────

sudo apt-get update -q
sudo apt-get install -y \
    aria2 \
    bat \
    btop \
    chafa \
    clang-format \
    cmake \
    fd-find \
    ffmpeg \
    fish \
    fzf \
    gcc \
    gh \
    git \
    git-lfs \
    httpie \
    python3-virtualenv \
    ripgrep \
    shellcheck \
    sox \
    tldr \
    tmux \
    unzip \
    webp \
    wget \
    xclip

# Create canonical names for tools apt installs under different names
if command -qa batcat; and not test -e ~/.local/bin/bat
    ln -sf (which batcat) ~/.local/bin/bat
end
if command -qa fdfind; and not test -e ~/.local/bin/fd
    ln -sf (which fdfind) ~/.local/bin/fd
end

# ── mise ─────────────────────────────────────────────────────────────────────

if not command -qa mise
    curl https://mise.run | sh
end

# ── starship ─────────────────────────────────────────────────────────────────

if not command -qa starship
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
end

# ── neovim ───────────────────────────────────────────────────────────────────

if not command -qa nvim
    set nvim_version (_latest_gh_release neovim/neovim)
    set nvim_arch (uname -m)
    curl -fsSL "https://github.com/neovim/neovim/releases/download/$nvim_version/nvim-linux-$nvim_arch.tar.gz" \
        | tar xz -C /tmp/
    cp /tmp/nvim-linux-$nvim_arch/bin/nvim ~/.local/bin/nvim
    rm -rf /tmp/nvim-linux-$nvim_arch
end

# ── git-delta ────────────────────────────────────────────────────────────────

if not command -qa delta
    set delta_version (_latest_gh_release dandavison/delta)
    set arch (_arch_musl)
    curl -fsSL "https://github.com/dandavison/delta/releases/download/$delta_version/delta-$delta_version-$arch-unknown-linux-musl.tar.gz" \
        | tar xz -C /tmp/
    cp /tmp/delta-$delta_version-$arch-unknown-linux-musl/delta ~/.local/bin/delta
    rm -rf /tmp/delta-$delta_version-$arch-unknown-linux-musl
end

# ── eza ──────────────────────────────────────────────────────────────────────

if not command -qa eza
    set eza_version (_latest_gh_release eza-community/eza)
    set arch (_arch_musl)
    curl -fsSL "https://github.com/eza-community/eza/releases/download/$eza_version/eza_$arch-unknown-linux-musl.tar.gz" \
        | tar xz -C ~/.local/bin/ eza
end

# ── dust ─────────────────────────────────────────────────────────────────────

if not command -qa dust
    set dust_version (_latest_gh_release bootandy/dust)
    set arch (_arch_musl)
    curl -fsSL "https://github.com/bootandy/dust/releases/download/$dust_version/dust-$dust_version-$arch-unknown-linux-musl.tar.gz" \
        | tar xz -C /tmp/
    cp /tmp/dust-$dust_version-$arch-unknown-linux-musl/dust ~/.local/bin/dust
    rm -rf /tmp/dust-$dust_version-$arch-unknown-linux-musl
end

# ── lazygit ──────────────────────────────────────────────────────────────────

if not command -qa lazygit
    set lazygit_version (string replace -r '^v' '' (_latest_gh_release jesseduffield/lazygit))
    set arch (string upper (_arch))
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v$lazygit_version/lazygit_"$lazygit_version"_Linux_$arch.tar.gz" \
        | tar xz -C ~/.local/bin/ lazygit
end

# ── lazydocker ───────────────────────────────────────────────────────────────

if not command -qa lazydocker
    set lazydocker_version (string replace -r '^v' '' (_latest_gh_release jesseduffield/lazydocker))
    set arch (string upper (_arch))
    curl -fsSL "https://github.com/jesseduffield/lazydocker/releases/download/v$lazydocker_version/lazydocker_"$lazydocker_version"_Linux_$arch.tar.gz" \
        | tar xz -C ~/.local/bin/ lazydocker
end

# ── k9s ──────────────────────────────────────────────────────────────────────

if not command -qa k9s
    set k9s_version (_latest_gh_release derailed/k9s)
    set arch (string upper (_arch))
    curl -fsSL "https://github.com/derailed/k9s/releases/download/$k9s_version/k9s_Linux_$arch.tar.gz" \
        | tar xz -C ~/.local/bin/ k9s
end

# ── kubectx + kubens ─────────────────────────────────────────────────────────

if not command -qa kubectx
    set kubectx_version (_latest_gh_release ahmetb/kubectx)
    set arch (_arch)
    curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/$kubectx_version/kubectx_"$kubectx_version"_linux_$arch.tar.gz" \
        | tar xz -C ~/.local/bin/ kubectx
    curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/$kubectx_version/kubens_"$kubectx_version"_linux_$arch.tar.gz" \
        | tar xz -C ~/.local/bin/ kubens
end

# ── zellij ───────────────────────────────────────────────────────────────────

if not command -qa zellij
    set zellij_version (_latest_gh_release zellij-org/zellij)
    set arch (_arch_musl)
    curl -fsSL "https://github.com/zellij-org/zellij/releases/download/$zellij_version/zellij-$arch-unknown-linux-musl.tar.gz" \
        | tar xz -C ~/.local/bin/ zellij
end

# ── shfmt ────────────────────────────────────────────────────────────────────

if not command -qa shfmt
    set shfmt_version (_latest_gh_release mvdan/sh)
    set arch (_arch)
    curl -fsSL "https://github.com/mvdan/sh/releases/download/$shfmt_version/shfmt_"$shfmt_version"_linux_$arch" \
        -o ~/.local/bin/shfmt
    chmod +x ~/.local/bin/shfmt
end

# ── prek ─────────────────────────────────────────────────────────────────────

if not command -qa prek
    set prek_version (_latest_gh_release j178/prek)
    set arch (_arch_musl)
    curl -fsSL "https://github.com/j178/prek/releases/download/$prek_version/prek-$arch-unknown-linux-musl.tar.gz" \
        | tar xz -C ~/.local/bin/ prek
end

# ── viu ──────────────────────────────────────────────────────────────────────

if not command -qa viu
    set viu_version (_latest_gh_release atanunq/viu)
    set arch (_arch_musl)
    curl -fsSL "https://github.com/atanunq/viu/releases/download/$viu_version/viu-$arch-unknown-linux-musl" \
        -o ~/.local/bin/viu
    chmod +x ~/.local/bin/viu
end

# ── atuin ────────────────────────────────────────────────────────────────────

if not command -qa atuin
    set atuin_version (_latest_gh_release atuinsh/atuin)
    set arch (_arch_musl)
    set atuin_tmp (mktemp -d)
    curl -fsSL "https://github.com/atuinsh/atuin/releases/download/$atuin_version/atuin-$arch-unknown-linux-musl.tar.gz" \
        | tar xz -C $atuin_tmp
    # Tarball layout varies across cargo-dist versions (flat vs nested dir).
    cp (find $atuin_tmp -type f -name atuin) ~/.local/bin/atuin
    rm -rf $atuin_tmp
end

# ── JetBrainsMono Nerd Font ───────────────────────────────────────────────────

set fonts_dir ~/.local/share/fonts
if not test -f "$fonts_dir/JetBrainsMonoNerdFont-Regular.ttf"
    set font_version (_latest_gh_release ryanoasis/nerd-fonts)
    curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/$font_version/JetBrainsMono.tar.xz" \
        -o /tmp/JetBrainsMono.tar.xz
    mkdir -p $fonts_dir
    tar xf /tmp/JetBrainsMono.tar.xz -C $fonts_dir
    fc-cache -fv $fonts_dir
    rm /tmp/JetBrainsMono.tar.xz
end
