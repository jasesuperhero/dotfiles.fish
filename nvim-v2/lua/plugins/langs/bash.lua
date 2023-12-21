return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = User.table.merge_options {
      ensure_installed = { "bash" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = User.table.merge_options {
      formatters_by_ft = {
        ["bash"] = { "shfmt" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = User.table.merge_options {
      ensure_installed = {
        "bash-debug-adapter",
        "bashls",
        "shellcheck",
        "shfmt",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = User.table.merge_options {
      servers = {
        bashls = {},
      },
    },
  },
}
