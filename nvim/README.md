# Neovim Configuration

NvChad v2.5-based configuration with Catppuccin theme, automatic dark/light mode switching, and full language support.

## Requirements

- Neovim >= 0.11
- Git
- [Nerd Font](https://www.nerdfonts.com/) (for icons)
- `stylua` — Lua formatter (used by pre-commit hooks in this repo)

## Installation

The bootstrap script symlinks `nvim/config` to `~/.config/nvim` automatically. To do it manually:

```sh
ln -s ~/.dotfiles/nvim/config ~/.config/nvim
```

## First launch

On the first launch, lazy.nvim will bootstrap itself and install all plugins. Once that completes:

1. **Install treesitter parsers**
   ```
   :TSUpdate
   ```

2. **Install LSP servers, formatters, and linters** — `mason-tool-installer` runs automatically after 3 seconds, but you can trigger it manually:
   ```
   :MasonToolsInstall
   ```

3. **Verify everything is set up**
   ```
   :Lazy       — plugin status
   :Mason      — installed tools
   :LspInfo    — active LSP servers (open a file first)
   :ConformInfo — active formatters (open a file first)
   ```

## Theme switching

The theme follows the macOS system appearance automatically. It reads `~/.vimrc.color`, which is written by the Fish `theme.fish` script when `C_THEME` changes.

- **Dark** → Catppuccin Mocha
- **Light** → Catppuccin Latte

To manually switch from the shell:

```sh
update_theme dark
update_theme light
```

## Language support

| Language   | LSP                        | Formatter   | Linter       |
|------------|----------------------------|-------------|--------------|
| Bash       | bashls                     | shfmt       | shellcheck   |
| CSS        | cssls                      | prettierd   |              |
| Fish       |                            | fish_indent |              |
| HTML       | html                       | prettierd   |              |
| JavaScript |                            | prettierd   | eslint_d     |
| JSON       | jsonls                     | prettierd   |              |
| Lua        | lua_ls                     | stylua      |              |
| Markdown   | marksman                   | prettierd   | markdownlint |
| Python     | pyright                    | black       | pylint       |
| Ruby       | solargraph                 | rubocop     |              |
| SCSS/Less  |                            | prettierd   |              |
| TypeScript | ts_ls                      | prettierd   | eslint_d     |
| YAML       | yamlls                     | prettierd   |              |

## Structure

```
config/
├── init.lua                  # Entry point, lazy.nvim bootstrap
└── lua/
    ├── chadrc.lua            # NvChad config (theme, UI)
    ├── options.lua           # Vim options
    ├── mappings.lua          # Custom keymaps
    ├── autocmds.lua          # Autocommands
    └── configs/
        ├── conform.lua       # Formatter config
        ├── lazy.lua          # Lazy.nvim settings
        ├── lint.lua          # Linter config
        ├── lspconfig.lua     # LSP server list
        └── watch_theme.lua   # File watcher for theme switching
    └── plugins/
        └── init.lua          # Plugin definitions
```
