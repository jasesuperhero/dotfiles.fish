return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "m-demare/hlargs.nvim",
      "nvim-treesitter/nvim-treesitter-context",
      "HiPhish/nvim-ts-rainbow2",
      "andymass/vim-matchup",
    },
    opts = {
      ensure_installed = {
        "bash",
        "cpp",
        "fish",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "lua",
        "python",
        "ruby",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "m-demare/hlargs.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require("hlargs").setup() end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
      }
    end,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          -- list of languages you want to disable the plugin for
          disable = { "jsx", "cpp" },
          -- Which query to use for finding delimiters
          query = "rainbow-parens",
          -- Highlight the entire buffer all at once
          strategy = require "ts-rainbow.strategy.global",
        },
      }
    end,
  },
  {
    "andymass/vim-matchup",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      require("nvim-treesitter.configs").setup {
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
        },
      }
    end,
  },
}
