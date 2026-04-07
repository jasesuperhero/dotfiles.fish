return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function() require "configs.lspconfig" end,
  },

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
    },
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
}
