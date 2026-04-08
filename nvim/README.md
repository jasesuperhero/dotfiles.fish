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

1. **Install LSP servers, formatters, and linters** — `mason-tool-installer` runs automatically after 3 seconds, but you can trigger it manually:

   ```
   :MasonToolsInstall
   ```

1. **Verify everything is set up**

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

## Keymaps

NvChad bundles `which-key.nvim`. Press `<leader>` (Space) and pause — a popup lists every available keymap under that prefix.

To browse all keymaps:

```
<leader>wK   — WhichKey: show all keymaps
<leader>wk   — WhichKey: query lookup (type a prefix to filter)
<leader>ch   — NvCheatsheet (NvChad built-in cheatsheet)
:Telescope keymaps
```

NvChad's built-in keymaps are defined in `~/.local/share/nvim/lazy/NvChad/lua/nvchad/mappings.lua`. Custom keymaps added on top live in `lua/mappings.lua`.

### Navigation

| Key         | Mode  | Description                                   |
| ----------- | ----- | --------------------------------------------- |
| `s`         | n/x/o | Flash jump (type chars to jump anywhere)      |
| `S`         | n/x/o | Flash Treesitter (jump to syntax node)        |
| `r`         | o     | Flash remote (operate on distant text object) |
| `R`         | o/x   | Flash Treesitter search                       |
| `j` / `k`   | n/x   | Move by display line on wrapped lines         |
| `<C-space>` | n     | Treesitter incremental selection (expand)     |
| `<bs>`      | x     | Treesitter incremental selection (shrink)     |
| `]]` / `[[` | n     | Next / prev reference (vim-illuminate)        |
| `]f` / `[f` | n     | Next / prev function start                    |
| `]F` / `[F` | n     | Next / prev function end                      |
| `]c` / `[c` | n     | Next / prev class start                       |

### Buffers

| Key               | Mode | Description                |
| ----------------- | ---- | -------------------------- |
| `<S-h>` / `<S-l>` | n    | Prev / next buffer         |
| `[b` / `]b`       | n    | Prev / next buffer         |
| `<leader>bb`      | n    | Switch to other buffer     |
| `<leader>,`       | n    | Switch buffer (MRU sorted) |
| `<leader>x`       | n    | Close buffer (NvChad)      |

### Search & Find

| Key               | Mode  | Description                                  |
| ----------------- | ----- | -------------------------------------------- |
| `n` / `N`         | n/x/o | Next / prev result (always forward/backward) |
| `<leader>ur`      | n     | Clear search highlight + redraw              |
| `<leader><space>` | n     | Find files                                   |
| `<leader>ff`      | n     | Find files (NvChad)                          |
| `<leader>fF`      | n     | Find files (cwd)                             |
| `<leader>fg`      | n     | Find git files                               |
| `<leader>fr`      | n     | Recent files                                 |
| `<leader>fw`      | n     | Live grep (NvChad)                           |
| `<leader>:`       | n     | Command history                              |

### Search (Telescope `<leader>s*`)

| Key                        | Description                |
| -------------------------- | -------------------------- |
| `<leader>sg`               | Grep                       |
| `<leader>sG`               | Grep (cwd)                 |
| `<leader>sw`               | Grep word under cursor     |
| `<leader>sW` (v)           | Grep selection             |
| `<leader>sd`               | Document diagnostics       |
| `<leader>sD`               | Workspace diagnostics      |
| `<leader>ss`               | Goto symbol (document)     |
| `<leader>sS`               | Goto symbol (workspace)    |
| `<leader>sk`               | Key maps                   |
| `<leader>sb`               | Buffer fuzzy find          |
| `<leader>sc` / `<leader>:` | Command history            |
| `<leader>sC`               | Commands                   |
| `<leader>sh`               | Help pages                 |
| `<leader>sH`               | Highlight groups           |
| `<leader>sM`               | Man pages                  |
| `<leader>sm`               | Marks                      |
| `<leader>so`               | Options                    |
| `<leader>sR`               | Resume last search         |
| `<leader>sa`               | Auto commands              |
| `<leader>s"`               | Registers                  |
| `<leader>sr`               | Replace in files (Spectre) |

### LSP & Diagnostics

| Key          | Mode | Description               |
| ------------ | ---- | ------------------------- |
| `gd`         | n    | Goto definition (NvChad)  |
| `gD`         | n    | Goto declaration (NvChad) |
| `gr`         | n    | References                |
| `gI`         | n    | Goto implementation       |
| `gy`         | n    | Goto type definition      |
| `K`          | n    | Hover docs                |
| `gK`         | n    | Signature help            |
| `<leader>ca` | n/v  | Code action               |
| `<leader>cc` | n/v  | Run codelens              |
| `<leader>cC` | n    | Refresh codelens          |
| `<leader>cA` | n/v  | Source action             |
| `<leader>cr` | n    | Rename                    |
| `<leader>cl` | n    | LSP info                  |
| `<leader>cd` | n    | Line diagnostics (float)  |
| `]d` / `[d`  | n    | Next / prev diagnostic    |
| `]e` / `[e`  | n    | Next / prev error         |
| `]w` / `[w`  | n    | Next / prev warning       |
| `<leader>fm` | n    | Format file (NvChad)      |
| `<leader>cs` | n    | Symbol outline (Aerial)   |

### Diagnostics list (Trouble)

| Key          | Description                                |
| ------------ | ------------------------------------------ |
| `<leader>xx` | Document diagnostics                       |
| `<leader>xX` | Workspace diagnostics                      |
| `<leader>xL` | Location list                              |
| `<leader>xQ` | Quickfix list                              |
| `[q` / `]q`  | Prev / next Trouble item or quickfix entry |

### Windows & Splits

| Key                    | Description                  |
| ---------------------- | ---------------------------- |
| `<leader>ww`           | Other window                 |
| `<leader>wd`           | Delete window                |
| `<leader>w-`           | Split below                  |
| `<leader>w\|`          | Split right                  |
| `<leader>-`            | Split below                  |
| `<leader>\|`           | Split right                  |
| `<Up/Down/Left/Right>` | Resize split (smart-splits)  |
| `<C-h/j/k/l>`          | Move between splits (NvChad) |

### Folds

| Key  | Description                |
| ---- | -------------------------- |
| `zR` | Open all folds             |
| `zM` | Close all folds            |
| `za` | Toggle fold under cursor   |
| `zk` | Go to previous start fold  |
| `zn` | Go to next closed fold     |
| `zp` | Go to previous closed fold |

### Session

| Key          | Description             |
| ------------ | ----------------------- |
| `<leader>qs` | Restore session for cwd |
| `<leader>ql` | Restore last session    |
| `<leader>qd` | Disable session saving  |

### UI Toggles

| Key          | Description                     |
| ------------ | ------------------------------- |
| `<leader>ut` | Toggle Treesitter context       |
| `<leader>un` | Dismiss notifications           |
| `<leader>uC` | Colorscheme picker with preview |

### Misc

| Key          | Mode | Description             |
| ------------ | ---- | ----------------------- |
| `<leader>w`  | n    | Save file               |
| `<C-s>`      | n    | Save file (NvChad)      |
| `<leader>/`  | n/v  | Toggle comment (NvChad) |
| `<leader>cp` | n    | Markdown preview toggle |
| `<leader>th` | n    | Switch NvChad theme     |
| `;`          | n    | Enter command mode      |
| `jk`         | i    | Exit insert mode        |
| `<esc><esc>` | t    | Exit terminal mode      |

## Language support

| Language   | LSP        | Formatter   | Linter       |
| ---------- | ---------- | ----------- | ------------ |
| Bash       | bashls     | shfmt       | shellcheck   |
| CSS        | cssls      | prettierd   |              |
| Fish       |            | fish_indent |              |
| HTML       | html       | prettierd   |              |
| JavaScript |            | prettierd   | eslint_d     |
| JSON       | jsonls     | prettierd   |              |
| Lua        | lua_ls     | stylua      |              |
| Markdown   | marksman   | prettierd   | markdownlint |
| Python     | pyright    | black       | pylint       |
| Ruby       | solargraph | rubocop     |              |
| SCSS/Less  |            | prettierd   |              |
| TypeScript | ts_ls      | prettierd   | eslint_d     |
| YAML       | yamlls     | prettierd   |              |

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
