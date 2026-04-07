return {
  -- ─── File explorer (neo-tree replaces NvChad's nvim-tree) ─────────────────

  { "nvim-tree/nvim-tree.lua", enabled = false },

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
      { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
      { "<leader>e", "<cmd>Neotree focus<cr>", desc = "Focus NeoTree" },
      { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Explorer (cwd)" },
      {
        "<leader>ge",
        function() require("neo-tree.command").execute { source = "git_status", toggle = true } end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function() require("neo-tree.command").execute { source = "buffers", toggle = true } end,
        desc = "Buffer Explorer",
      },
    },
  },

  -- ─── which-key groups ─────────────────────────────────────────────────────

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        -- leader prefix groups
        { "<leader>b", group = "buffers", icon = { icon = "󰈔", color = "cyan" } },
        { "<leader>c", group = "code", icon = { icon = "", color = "orange" } },
        { "<leader>d", group = "diagnostics", icon = { icon = "", color = "red" } },
        { "<leader>f", group = "find/file", icon = { icon = "", color = "yellow" } },
        { "<leader>g", group = "git", icon = { icon = "", color = "green" } },
        { "<leader>m", group = "marks", icon = { icon = "", color = "cyan" } },
        { "<leader>p", group = "pick", icon = { icon = "", color = "purple" } },
        { "<leader>q", group = "quit/session", icon = { icon = "", color = "red" } },
        { "<leader>r", group = "rename", icon = { icon = "󰑕", color = "orange" } },
        { "<leader>s", group = "search", icon = { icon = "", color = "yellow" } },
        { "<leader>t", group = "theme", icon = { icon = "󰏘", color = "purple" } },
        { "<leader>u", group = "ui", icon = { icon = "󰙵", color = "cyan" } },
        { "<leader>w", group = "windows", icon = { icon = "", color = "blue" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "", color = "red" } },
        -- motion prefix groups
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
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
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
        -- formatters
        "prettierd",
        "shfmt",
        "black",
        "rubocop",
        "stylua",
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

  -- ─── Telescope (extra keymaps on top of NvChad defaults) ─────────────────

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      -- find
      { "<leader>fF", "<cmd>Telescope find_files cwd=false<cr>", desc = "Find Files (cwd)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>sG", "<cmd>Telescope live_grep cwd=false<cr>", desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Word" },
      { "<leader>sW", "<cmd>Telescope grep_string<cr>", mode = "v", desc = "Selection" },
      { "<leader>ss", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Goto Symbol" },
      {
        "<leader>sS",
        function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        desc = "Goto Symbol (Workspace)",
      },
      {
        "<leader>uC",
        function() require("telescope.builtin").colorscheme { enable_preview = true } end,
        desc = "Colorscheme with Preview",
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
        "javascript",
        "json",
        "json5",
        "jsonc",
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
        desc = "Toggle Treesitter Context",
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
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    opts = function() return require "configs.ufo" end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zk", function() require("ufo").goPreviousStartFold() end, desc = "Go previous start fold" },
      { "zn", function() require("ufo").goNextClosedFold() end, desc = "Go next closed fold" },
      { "zp", function() require("ufo").goPreviousClosedFold() end, desc = "Go previous closed fold" },
    },
  },

  -- ─── Core UX ──────────────────────────────────────────────────────────────

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix List" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev { skip_groups = true, jump = true }
          else
            pcall(vim.cmd.cprev)
          end
        end,
        desc = "Previous Trouble/Quickfix",
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
        desc = "Next Trouble/Quickfix",
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
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load { last = true } end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Session" },
    },
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
    },
  },

  {
    "stevearc/aerial.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function() return require "configs.aerial" end,
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
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
        desc = "Dismiss Notifications",
      },
    },
  },

  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    keys = {
      { "<Up>", function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
      { "<Down>", function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
      { "<Left>", function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
      { "<Right>", function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
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
        vim.keymap.set(
          "n",
          key,
          function() require("illuminate")["goto_" .. dir .. "_reference"](false) end,
          { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer }
        )
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

  {
    "luukvbaal/statuscol.nvim",
    branch = "0.10",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        relculright = true,
        segments = {
          { sign = { namespace = { "diagnostic" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
          {
            sign = { namespace = { "gitsigns" }, name = { ".*" }, maxwidth = 2, colwidth = 2, auto = true },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        },
        ft_ignore = { "help", "vim", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
      }
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
      show_borders = false,
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
      local lspkind = require "lspkind"
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
      cmp.setup(opts)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },

  -- ─── Language ─────────────────────────────────────────────────────────────

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview" },
    },
  },
}
