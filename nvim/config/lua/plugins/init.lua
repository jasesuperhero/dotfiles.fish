return {
  -- ─── File explorer (neo-tree replaces NvChad's nvim-tree) ─────────────────

  { "nvim-tree/nvim-tree.lua", enabled = false },

  -- ─── Gitsigns ─────────────────────────────────────────────────────────────

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▾" },
        topdelete = { text = "▴" },
        changedelete = { text = "▎" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▾" },
        topdelete = { text = "▴" },
        changedelete = { text = "▎" },
      },
    },
  },

  -- ─── Git UI ───────────────────────────────────────────────────────────────

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    opts = {},
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = " Diff View" },
      { "<leader>gD", "<cmd>DiffviewFileHistory %<cr>", desc = " File History" },
    },
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      graph_style = "unicode",
      integrations = {
        diffview = true,
        telescope = true,
      },
      commit_editor = {
        kind = "tab",
        show_staged_diff = true,
        staged_diff_split_kind = "split",
      },
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = " Neogit" },
    },
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      default_mappings = false, -- use the <leader>gx* maps below instead of co/ct/cb
      default_commands = true,
      disable_diagnostics = false,
      list_opener = "copen",
    },
    keys = {
      { "<leader>gxo", "<cmd>GitConflictChooseOurs<cr>", desc = " Choose Ours" },
      { "<leader>gxt", "<cmd>GitConflictChooseTheirs<cr>", desc = " Choose Theirs" },
      { "<leader>gxb", "<cmd>GitConflictChooseBoth<cr>", desc = " Choose Both" },
      { "<leader>gx0", "<cmd>GitConflictChooseNone<cr>", desc = " Choose None" },
      { "<leader>gxl", "<cmd>GitConflictListQf<cr>", desc = " List Conflicts" },
      { "]x", "<cmd>GitConflictNextConflict<cr>", desc = " Next Conflict" },
      { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = " Prev Conflict" },
    },
  },

  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      picker = "telescope",
      enable_builtin = true,
      default_merge_method = "squash",
      reviews = {
        auto_show_threads = true,
        focus = "right",
      },
    },
    keys = {
      { "<leader>ghi", "<cmd>Octo issue list<cr>", desc = " Issues" },
      { "<leader>ghI", "<cmd>Octo issue create<cr>", desc = " New Issue" },
      { "<leader>ghp", "<cmd>Octo pr list<cr>", desc = " Pull Requests" },
      { "<leader>ghP", "<cmd>Octo pr create<cr>", desc = " New PR" },
      { "<leader>ghs", "<cmd>Octo search<cr>", desc = " Search" },
      { "<leader>ghr", "<cmd>Octo repo list<cr>", desc = " Repos" },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = { "MunifTanjim/nui.nvim" },
    init = function()
      -- open neo-tree when nvim is called with a directory argument
      if vim.fn.argc(-1) == 1 then
        local stat = vim.uv.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require "neo-tree" end
      end
    end,
    deactivate = function() vim.cmd "Neotree close" end,
    opts = require "configs.neotree",
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "󰙅 Toggle NeoTree" },
      { "<leader>e", "<cmd>Neotree focus<cr>", desc = "󰙅 Focus NeoTree" },
      { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = " Explorer (cwd)" },
      {
        "<leader>ge",
        function() require("neo-tree.command").execute { source = "git_status", toggle = true } end,
        desc = " Git Explorer",
      },
      {
        "<leader>be",
        function() require("neo-tree.command").execute { source = "buffers", toggle = true } end,
        desc = "󰈔 Buffer Explorer",
      },
    },
  },

  -- ─── which-key groups ─────────────────────────────────────────────────────

  {
    "folke/which-key.nvim",
    opts = {
      win = { border = "rounded" },
      spec = {
        { "<leader>b", group = "buffers", icon = { icon = "󰈔", color = "cyan" } },
        { "<leader>c", group = "code", icon = { icon = "", color = "orange" } },
        { "<leader>d", group = "diagnostics", icon = { icon = "", color = "red" } },
        { "<leader>f", group = "find/file", icon = { icon = "", color = "yellow" } },
        { "<leader>g", group = "git", icon = { icon = "", color = "green" } },
        { "<leader>gh", group = "github", icon = { icon = "", color = "blue" } },
        { "<leader>gx", group = "conflict", icon = { icon = "", color = "red" } },
        { "<leader>m", group = "marks", icon = { icon = "", color = "cyan" } },
        { "<leader>p", group = "pick", icon = { icon = "", color = "purple" } },
        { "<leader>q", group = "quit/session", icon = { icon = "", color = "red" } },
        { "<leader>r", group = "rename", icon = { icon = "󰑕", color = "orange" } },
        { "<leader>s", group = "search", icon = { icon = "", color = "yellow" } },
        { "<leader>t", group = "theme", icon = { icon = "󰏘", color = "purple" } },
        { "<leader>u", group = "ui", icon = { icon = "󰙵", color = "cyan" } },
        { "<leader>w", group = "windows", icon = { icon = "", color = "blue" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "", color = "red" } },
        { "<leader>a", group = "ai", icon = { icon = "󰚩", color = "cyan" } },
        { "<leader>o", group = "obsidian", icon = { icon = "󱓼", color = "purple" } },
        { "g", group = "goto", icon = { icon = "", color = "blue" } },
        { "gs", group = "surround", icon = { icon = "󰅲", color = "orange" } },
        { "z", group = "fold", icon = { icon = "", color = "yellow" } },
        { "]", group = "next", icon = { icon = "", color = "green" } },
        { "[", group = "prev", icon = { icon = "", color = "green" } },
      },
    },
  },

  -- ─── Language / formatting / linting ──────────────────────────────────────

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = require "configs.conform",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format { async = true, lsp_fallback = true } end,
        mode = { "n", "v" },
        desc = " Format",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/SchemaStore.nvim" },
    config = function() require "configs.lspconfig" end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = require "configs.lint"
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = { ui = { border = "rounded" } },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "bash-language-server",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "pyright",
        "solargraph",
        "typescript-language-server",
        "yaml-language-server",
        "kotlin-language-server",
        "jdtls",
        -- formatters
        "prettierd",
        "shfmt",
        "black",
        "rubocop",
        "stylua",
        "ktlint",
        -- linters
        "shellcheck",
        "markdownlint",
        "pylint",
        "eslint_d",
      },
      run_on_start = true,
      start_delay = 3000,
    },
  },

  -- ─── Telescope ────────────────────────────────────────────────────────────

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
            ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
          },
        },
      })
      return opts
    end,
    keys = {
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "󰓩 Switch Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = " Command History" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = " Find Files" },
      -- find
      { "<leader>fF", "<cmd>Telescope find_files cwd=false<cr>", desc = " Find Files (cwd)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = " Find Files (git)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "󰋚 Recent Files" },
      -- git
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = " Changed Files" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "󱆐 Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = " Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = " Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = " Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = " Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = " Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = " Workspace Diagnostics" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = " Grep" },
      { "<leader>sG", "<cmd>Telescope live_grep cwd=false<cr>", desc = " Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "󰋖 Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = " Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = " Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = " Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = " Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = " Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = " Resume" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = " Word" },
      { "<leader>sW", "<cmd>Telescope grep_string<cr>", mode = "v", desc = " Selection" },
      {
        "<leader>ss",
        function() require("telescope.builtin").lsp_document_symbols() end,
        desc = " Goto Symbol",
      },
      {
        "<leader>sS",
        function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        desc = " Goto Symbol (Workspace)",
      },
      {
        "<leader>uC",
        function() require("telescope.builtin").colorscheme { enable_preview = true } end,
        desc = " Colorscheme with Preview",
      },
    },
  },

  -- ─── Treesitter ───────────────────────────────────────────────────────────

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "diff",
        "query",
        "regex",
        "bash",
        "css",
        "fish",
        "git_config",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "html",
        "java",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "kotlin",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "ninja",
        "python",
        "ruby",
        "rst",
        "scss",
        "swift",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
      matchup = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      {
        "<leader>ut",
        function() require("treesitter-context").toggle() end,
        desc = " Toggle Treesitter Context",
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "VimEnter",
    init = function()
      vim.o.foldcolumn = "auto"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldnestmax = 0
      vim.o.foldenable = true
      vim.o.foldmethod = "indent"
    end,
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        branch = "0.10",
        opts = function()
          local builtin = require "statuscol.builtin"
          return {
            relculright = true,
            bt_ignore = { "nofile", "prompt", "terminal", "packer" },
            ft_ignore = {
              "NvimTree",
              "dashboard",
              "nvcheatsheet",
              "dapui_watches",
              "dap-repl",
              "dapui_console",
              "dapui_stacks",
              "dapui_breakpoints",
              "dapui_scopes",
              "help",
              "vim",
              "alpha",
              "neo-tree",
              "Trouble",
              "noice",
              "lazy",
              "toggleterm",
            },
            segments = {
              { text = { " " } },
              {
                text = { builtin.foldfunc },
                click = "v:lua.ScFa",
                maxwidth = 1,
                colwidth = 1,
                auto = false,
              },
              { text = { " " } },
              {
                sign = { name = { ".*" }, namespace = { ".*" }, maxwidth = 1, colwidth = 1 },
                auto = true,
                click = "v:lua.ScSa",
              },
              {
                text = { " ", " ", builtin.lnumfunc, " " },
                click = "v:lua.ScLa",
                condition = { true, builtin.not_empty },
              },
              {
                sign = { namespace = { "gitsign.*" }, maxwidth = 1, colwidth = 1, auto = false },
                click = "v:lua.ScSa",
              },
              { text = { " " }, hl = "Normal", condition = { true, builtin.not_empty } },
            },
          }
        end,
      },
    },
    opts = function() return require "configs.ufo" end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = " Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = " Close all folds" },
      { "zk", function() require("ufo").goPreviousStartFold() end, desc = " Go previous start fold" },
      { "zn", function() require("ufo").goNextClosedFold() end, desc = " Go next closed fold" },
      { "zp", function() require("ufo").goPreviousClosedFold() end, desc = " Go previous closed fold" },
    },
  },

  -- ─── Core UX ──────────────────────────────────────────────────────────────

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = " Flash" },
      {
        "S",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = " Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = " Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = " Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = " Toggle Flash Search",
      },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      win = { border = "rounded" },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = " Document Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = " Workspace Diagnostics" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = " Location List" },
      { "<leader>xQ", "<cmd>Trouble quickfix toggle<cr>", desc = " Quickfix List" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev { skip_groups = true, jump = true }
          else
            pcall(vim.cmd.cprev)
          end
        end,
        desc = " Previous Trouble/Quickfix",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            pcall(vim.cmd.cnext)
          end
        end,
        desc = " Next Trouble/Quickfix",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = { signs = false },
  },

  {
    "folke/persistence.nvim",
    lazy = true,
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = " Restore Session" },
      { "<leader>ql", function() require("persistence").load { last = true } end, desc = " Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = " Don't Save Session" },
    },
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = " Replace in Files (Spectre)" },
    },
  },

  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialClose" },
    opts = function() return require "configs.aerial" end,
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = " Aerial (Symbols)" },
    },
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = { border = "rounded" },
      select = { builtin = { border = "rounded" } },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
  },

  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    opts = {
      render = "compact",
      stages = "slide",
      border = "rounded",
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
    },
    config = function(_, opts)
      local notify = require "notify"
      notify.setup(opts)
      vim.notify = notify
    end,
    keys = {
      {
        "<leader>un",
        function() require("notify").dismiss { silent = true, pending = true } end,
        desc = " Dismiss Notifications",
      },
    },
  },

  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    keys = {
      -- navigate between neovim splits and zellij panes seamlessly
      { "<A-h>", function() require("smart-splits").move_cursor_left() end, desc = " Move to left split" },
      { "<A-j>", function() require("smart-splits").move_cursor_down() end, desc = " Move to below split" },
      { "<A-k>", function() require("smart-splits").move_cursor_up() end, desc = " Move to above split" },
      { "<A-l>", function() require("smart-splits").move_cursor_right() end, desc = " Move to right split" },
      -- resize splits
      { "<Up>", function() require("smart-splits").resize_up(2) end, desc = " Resize split up" },
      { "<Down>", function() require("smart-splits").resize_down(2) end, desc = " Resize split down" },
      { "<Left>", function() require("smart-splits").resize_left(2) end, desc = " Resize split left" },
      { "<Right>", function() require("smart-splits").resize_right(2) end, desc = " Resize split right" },
    },
    opts = {
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
    },
  },

  -- ─── Editor enhancements ──────────────────────────────────────────────────

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = { providers = { "lsp" } },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function() require("illuminate")["goto_" .. dir .. "_reference"](false) end, {
          desc = (dir == "next" and " " or " ") .. dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference",
          buffer = buffer,
        })
      end
      map("]]", "next")
      map("[[", "prev")
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
  },

  {
    "andymass/vim-matchup",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local rd = require "rainbow-delimiters"
      require("rainbow-delimiters.setup").setup {
        strategy = {
          [""] = rd.strategy["global"],
          vim = rd.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "m-demare/hlargs.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "▏",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason", "notify" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },

  -- ─── LSP & completion extras ──────────────────────────────────────────────

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = { display = { done_icon = "" } },
      integration = { ["nvim-tree"] = { enable = true } },
      notification = { window = { winblend = 0 } },
    },
  },

  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
      enable = true,
      max_width = 60,
      max_height = 10,
      severity_colors = {
        error = "DiagnosticFloatingError",
        warning = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
      },
      format = function(diag) return diag.message end,
      gap_size = 1,
      scope = "cursor",
      padding_top = 1,
      text_align = "left",
      placement = "top",
      show_sign = true,
      show_borders = true,
      render_event = { "DiagnosticChanged", "CursorMoved" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-cmdline",
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      local lspkind = require "lspkind"
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-h>"] = cmp.mapping.scroll_docs(-4),
        ["<C-l>"] = cmp.mapping.scroll_docs(4),
      })
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        },
      }
      table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
      return opts
    end,
    config = function(_, opts)
      local cmp = require "cmp"
      local cmdline_mappings = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), {
        ["<C-j>"] = { c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert } },
        ["<C-k>"] = { c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert } },
      })
      cmp.setup(opts)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmdline_mappings,
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmdline_mappings,
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },

  -- ─── Obsidian ─────────────────────────────────────────────────────────────

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = require "configs.obsidian",
    init = function()
      local vault = vim.fn.expand "~/Documents/notes"
      vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
        pattern = vault .. "/*.md",
        once = true,
        callback = function() require("lazy").load { plugins = { "obsidian.nvim" } } end,
      })
    end,
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = " New Note" },
      { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = " Open Note" },
      { "<leader>od", "<cmd>ObsidianToday<cr>", desc = " Daily Note" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = " Backlinks" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = " Search Notes" },
      { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = " Tags" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = " Links" },
      { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = " Follow Link" },
      { "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = " Workspace" },
      { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "󰑕 Rename Note" },
      { "<leader>oz", "<cmd>ObsidianTemplate<cr>", desc = " Insert Template" },
    },
  },

  -- ─── Claude Code ──────────────────────────────────────────────────────────

  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeContinue" },
    opts = {
      window = {
        split_ratio = 0.4,
        position = "vertical",
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "󰚩 Claude Code" },
      { "<leader>ar", "<cmd>ClaudeCodeContinue<cr>", desc = " Resume Chat" },
    },
  },

  -- ─── Language ─────────────────────────────────────────────────────────────

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = " Markdown Preview" },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- icons above code blocks
    },
    opts = {},
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = " Toggle Markdown Render" },
    },
  },
}
