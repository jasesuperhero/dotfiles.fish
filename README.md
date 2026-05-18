# Daniel's dotfiles

Config files for Fish, Neovim, Zellij, Kitty, Ghostty, and more — macOS and Linux.

______________________________________________________________________

<!--toc:start-->

- [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Install](#install)
  - [Update](#update)
- [Revert](#revert)
- [Recommended software](#recommended-software)
- [macOS defaults](#macos-defaults)
- [Theme](#theme)

<!--toc:end-->

## Installation

### Dependencies

- `git`
- `curl`
- `fish` — install via `brew install fish` or from [fishshell.com](https://fishshell.com)

### Install

```sh
git clone https://github.com/jasesuperhero/dotfiles.fish.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap.fish
```

The bootstrap script will:

1. **macOS:** Install Homebrew (if missing) and run `brew bundle` — **Linux:** install apt packages and download binaries from GitHub releases
1. Symlink all config files to their expected locations
1. Prompt for git `user.name` / `user.email` on a fresh machine
1. Install [Fisher](https://github.com/jorgebucaran/fisher) and all plugins
1. Set Fish as the default shell

> Existing files are backed up with a `.backup` suffix before being replaced.

### Update

```sh
cd ~/.dotfiles
git pull origin master
./script/bootstrap.fish
```

## Revert

Remove the dotfiles and Fish config:

```sh
rm -rf ~/.dotfiles ~/.config/fish
```

Find any backed-up originals with:

```sh
fd -e backup -H -E Library -d 3 .
```

Then manually restore as needed.

## Recommended software

Everything below is installed automatically by bootstrap — via `Brewfile` on macOS, or via apt + GitHub releases on Linux.

| Tool                                                        | Description                                         |
| ----------------------------------------------------------- | --------------------------------------------------- |
| [`bat`](https://github.com/sharkdp/bat)                     | `cat` with syntax highlighting                      |
| [`delta`](https://github.com/dandavison/delta)              | Better git diffs                                    |
| [`dust`](https://github.com/bootandy/dust)                  | Intuitive `du` replacement                          |
| [`eza`](https://github.com/eza-community/eza)               | Modern `ls` replacement                             |
| [`fd`](https://github.com/sharkdp/fd)                       | Fast, user-friendly `find`                          |
| [`fzf`](https://github.com/junegunn/fzf)                    | Fuzzy finder                                        |
| [`gh`](https://github.com/cli/cli)                          | GitHub CLI                                          |
| [`k9s`](https://k9scli.io)                                  | Kubernetes TUI                                      |
| [`kubectx`](https://github.com/ahmetb/kubectx)              | Fast Kubernetes context/namespace switching         |
| [`lazydocker`](https://github.com/jesseduffield/lazydocker) | Docker TUI                                          |
| [`lazygit`](https://github.com/jesseduffield/lazygit)       | Git TUI                                             |
| [`mise`](https://mise.jdx.dev)                              | Runtime version manager (Node, Python, Ruby, Go, …) |
| [`neovim`](https://neovim.io)                               | Editor — see [nvim/README.md](nvim/README.md)       |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep)          | Fast `grep`                                         |
| [`starship`](https://starship.rs)                           | Cross-shell prompt                                  |
| [`zellij`](https://zellij.dev)                              | Terminal multiplexer                                |

**Terminals:** [Kitty](https://sw.kovidgoyal.net/kitty) and [Ghostty](https://ghostty.org)

**Claude Code:** Zellij status integration + macOS notifications — see [claude-code/README.md](claude-code/README.md).

**macOS apps (via cask):** Alfred, Bartender, Docker, Fork, IINA, Kap, Karabiner-Elements, Obsidian, Postman, Stats, and more.

**Mac App Store:** Magnet, Spark, Things, Next Meeting, Noizio.

## macOS defaults

```sh
~/.dotfiles/macos/set-defaults.sh
```

Log out and back in (or restart) for all changes to take effect.

## Theme

[Catppuccin](https://github.com/catppuccin/catppuccin) across all tools — **Mocha** in dark mode, **Latte** in light mode.

On macOS, the theme switches automatically with the system appearance via `osx-dark-mode-notify`. To switch manually:

```sh
update_theme dark
update_theme light
```

**Font:** [JetBrainsMono Nerd Font](https://www.nerdfonts.com), 16 pt.
