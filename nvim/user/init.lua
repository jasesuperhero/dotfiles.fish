--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below
-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

        -- Configure AstroNvim updates
        updater = {
                remote = "origin", -- remote to use
                channel = "nightly", -- "stable" or "nightly"
                version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
                branch = "main", -- branch name (NIGHTLY ONLY)
                commit = nil, -- commit hash (NIGHTLY ONLY)
                pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
                skip_prompts = false, -- skip prompts about breaking changes
                show_changelog = true, -- show the changelog after performing an update
                auto_reload = false, -- automatically reload and sync packer after a successful update
                auto_quit = false, -- automatically quit the current session after a successful update
        },

        -- Set colorscheme to use
        colorscheme = "catppuccin",

        -- set vim options here (vim.<first_key>.<second_key> = value)
        options = {
                opt = {
                        -- set to true or false etc.
                        relativenumber = true, -- sets vim.opt.relativenumber
                        number = true, -- sets vim.opt.number
                        spell = false, -- sets vim.opt.spell
                        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
                        wrap = false, -- sets vim.opt.wrap
                        laststatus = 2, -- disable gloabal status bar
                },
                g = {
                        mapleader = " ", -- sets vim.g.mapleader
                        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
                        cmp_enabled = true, -- enable completion at start
                        autopairs_enabled = true, -- enable autopairs at start
                        diagnostics_enabled = true, -- enable diagnostics at start
                        status_diagnostics_enabled = true, -- enable diagnostics in statusline
                        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
                        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
                },
        },

        -- Set dashboard header
        header = {
                " █████  ███████ ████████ ██████   ██████",
                "██   ██ ██         ██    ██   ██ ██    ██",
                "███████ ███████    ██    ██████  ██    ██",
                "██   ██      ██    ██    ██   ██ ██    ██",
                "██   ██ ███████    ██    ██   ██  ██████",
                " ",
                "    ███    ██ ██    ██ ██ ███    ███",
                "    ████   ██ ██    ██ ██ ████  ████",
                "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
                "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
                "    ██   ████   ████   ██ ██      ██",
        },

        -- Default theme configuration
        default_theme = {
                highlights = function(hl) -- or a function that returns a new table of colors to set
                        local C = require "default_theme.colors"

                        hl.Normal = {
                                fg = C.fg,
                                bg = C.bg,
                        }

                        -- New approach instead of diagnostic_style
                        hl.DiagnosticError.italic = true
                        hl.DiagnosticHint.italic = true
                        hl.DiagnosticInfo.italic = true
                        hl.DiagnosticWarn.italic = true

                        return hl
                end,
        },

        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {
                virtual_text = true,
                underline = true,
        },

        -- Extend LSP configuration
        lsp = {
                -- enable servers that you already have installed without mason
                servers = {
                        "sumneko_lua",
                        "sourcekit",
                },
                formatting = {
                        -- control auto formatting on save
                        format_on_save = {
                                enabled = true, -- enable or disable format on save globally
                        },
                        timeout_ms = 1000, -- default format timeout
                },
                -- easily add or disable built in mappings added during LSP attaching
                mappings = {
                        n = {
                                -- ["<leader>lf"] = false -- disable formatting keymap
                        },
                },
        },

        -- Mapping data with "desc" stored directly by vim.keymap.set().
        --
        -- Please use this mappings table to set keyboard mapping since this is the
        -- lower level configuration and more robust one. (which-key will
        -- automatically pick-up stored data by this setting.)
        mappings = {
                -- first key is the mode
                n = {
                        -- second key is the lefthand side of the map
                        -- mappings seen under group name "Buffer"
                        ["<leader>bb"] = {
                                "<cmd>tabnew<cr>",
                                desc = "New tab",
                        },
                        ["<leader>bc"] = {
                                "<cmd>BufferLinePickClose<cr>",
                                desc = "Pick to close",
                        },
                        ["<leader>bj"] = {
                                "<cmd>BufferLinePick<cr>",
                                desc = "Pick to jump",
                        },
                        ["<leader>bt"] = {
                                "<cmd>BufferLineSortByTabs<cr>",
                                desc = "Sort by tabs",
                        },
                },
                t = {
                        -- setting a mapping to false will disable it
                        -- ["<esc>"] = false,
                },
        },

        -- Configure plugins
        plugins = {
                init = {
                        {
                                "catppuccin/nvim",
                                as = "catppuccin",
                                config = function()
                                        require("catppuccin").setup {
                                                flavour = "mocha", -- latte, frappe, macchiato, mocha
                                                background = { -- :h background
                                                        light = "latte",
                                                        dark = "mocha",
                                                },
                                                transparent_background = false,
                                                term_colors = false,
                                                dim_inactive = {
                                                        enabled = false,
                                                        shade = "dark",
                                                        percentage = 0.15,
                                                },
                                                styles = {
                                                        comments = { "italic" },
                                                        conditionals = { "italic" },
                                                        loops = {},
                                                        functions = {},
                                                        keywords = {},
                                                        strings = {},
                                                        variables = {},
                                                        numbers = {},
                                                        booleans = {},
                                                        properties = {},
                                                        types = {},
                                                        operators = {},
                                                },
                                        }
                                end,
                        },
                        {
                                "klen/nvim-test",
                                config = function()
                                        require("nvim-test").setup {
                                                run = true, -- run tests (using for debug)
                                                commands_create = true, -- create commands (TestFile, TestLast, ...)
                                                filename_modifier = ":.", -- modify filenames before tests run(:h filename-modifiers)
                                                silent = false, -- less notifications
                                                term = "terminal", -- a terminal to run ("terminal"|"toggleterm")
                                                termOpts = {
                                                        direction = "vertical", -- terminal's direction ("horizontal"|"vertical"|"float")
                                                        width = 96, -- terminal's width (for vertical|float)
                                                        height = 24, -- terminal's height (for horizontal|float)
                                                        go_back = false, -- return focus to original window after executing
                                                        stopinsert = "auto", -- exit from insert mode (true|false|"auto")
                                                        keep_one = true, -- keep only one terminal for testing
                                                },
                                                runners = { -- setup tests runners
                                                        cs = "nvim-test.runners.dotnet",
                                                        go = "nvim-test.runners.go-test",
                                                        haskell = "nvim-test.runners.hspec",
                                                        javascriptreact = "nvim-test.runners.jest",
                                                        javascript = "nvim-test.runners.jest",
                                                        lua = "nvim-test.runners.busted",
                                                        python = "nvim-test.runners.pytest",
                                                        ruby = "nvim-test.runners.rspec",
                                                        rust = "nvim-test.runners.cargo-test",
                                                        typescript = "nvim-test.runners.jest",
                                                        typescriptreact = "nvim-test.runners.jest",
                                                },
                                        }
                                end,
                        },
                        -- Add lazy loading for command line
                        -- that triggers the loading of cmp
                        ["hrsh7th/nvim-cmp"] = { keys = { ":", "/", "?" } },
                        -- add more custom sources
                        ["hrsh7th/cmp-cmdline"] = { after = "nvim-cmp" },
                        -- add lsp signature help for method arguments
                        {
                                "hrsh7th/cmp-nvim-lsp-signature-help",
                                after = "nvim-cmp",
                                config = function()
                                        astronvim.add_user_cmp_source "nvim_lsp_signature_help"
                                end,
                        },
                        -- add material icons instead of default dev icons
                        ["DaikyXendo/nvim-material-icon"] = { as = "nvim-material-icon" },
                        -- standart dev icons
                        ["nvim-tree/nvim-web-devicons"] = { after = "nvim-material-icon" },
                },
                treesitter = { -- overrides `require("treesitter").setup(...)`
                        ensure_installed = {
                                "bash",
                                "fish",
                                "lua",
                                "python",
                                "ruby",
                                "cpp",
                                "gitignore",
                                "gitcommit",
                                "gitattributes",
                        },
                },
                ["mason-lspconfig"] = {
                        ensure_installed = {
                                "sumneko_lua",
                                "solargraph",
                                "pyright",
                                "bashls",
                                "clangd",
                        },
                },
                -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
                ["mason-null-ls"] = {
                        ensure_installed = {
                                "prettier",
                                "stylua",
                                "shellcheck",
                                "shfmt",
                                "clang-format",
                        },
                },
                ["notify"] = {
                        background_colour = "#000000",
                },
        },

        -- LuaSnip Options
        luasnip = {
                -- Extend filetypes
                filetype_extend = {
                        -- javascript = { "javascriptreact" },
                },
                -- Configure luasnip loaders (vscode, lua, and/or snipmate)
                vscode = {
                        -- Add paths for including more VS Code style snippets in luasnip
                        paths = {},
                },
        },

        -- CMP Source Priorities
        -- modify here the priorities of default cmp sources
        -- higher value == higher priority
        -- The value can also be set to a boolean for disabling default sources:
        -- false == disabled
        -- true == 1000
        cmp = {
                source_priority = {
                        nvim_lsp = 1000,
                        nvim_lsp_signature_help = 800,
                        luasnip = 750,
                        buffer = 500,
                        path = 250,
                },
                setup = function()
                        -- load cmp to access it's internal functions
                        local cmp = require "cmp"
                        local user_source = astronvim.get_user_cmp_source

                        -- store a local variable with a source list to share between filetypes
                        local prose_sources = {
                                user_source "luasnip",
                                user_source "buffer",
                        }

                        -- configure mappings for cmdline
                        local fallback_func = function(func)
                                return function(fallback)
                                        if cmp.visible() then
                                                cmp[func]()
                                        else
                                                fallback()
                                        end
                                end
                        end
                        local mappings = cmp.mapping.preset.cmdline {
                                ["<C-j>"] = { c = fallback_func "select_next_item" },
                                ["<C-k>"] = { c = fallback_func "select_prev_item" },
                        }
                        local config = {
                                -- configure cmp.setup.filetype(filetype, options)
                                filetype = {
                                        -- first key is the filetype that you are setting up
                                        lua = { -- for lua only load lsp sources and buffer sources as a fallback
                                                sources = cmp.config.sources({
                                                        user_source "nvim_lsp",
                                                }, {
                                                        user_source "buffer",
                                                }),
                                        },
                                        -- markdown and latex share the same sources
                                        markdown = { sources = prose_sources },
                                        latex = { sources = prose_sources },
                                },
                                -- configure cmp.setup.cmdline(source, options)
                                cmdline = {
                                        -- first key is the source that you are setting up
                                        [":"] = {
                                                -- set up custom mappings
                                                mapping = mappings,
                                                -- configure sources normally without getting priority from cmp.source_priority
                                                sources = cmp.config.sources({ { name = "path" } },
                                                        { { name = "cmdline" } }),
                                        },
                                        ["/"] = { mapping = mappings, sources = { { name = "buffer" } } },
                                        ["?"] = { mapping = mappings, sources = { { name = "buffer" } } },
                                },
                        }

                        -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                        -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

                        -- return config
                        return config
                end,
        },
}

return config
