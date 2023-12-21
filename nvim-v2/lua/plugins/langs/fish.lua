return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = User.table.merge_options {
      ensure_installed = { "fish" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = User.table.merge_options {
      formatters_by_ft = {
        ["fish"] = { "shfmt", "fish_indent" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = User.table.merge_options {
      linters_by_ft = {
        fish = { "fish" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = User.table.merge_options {
      ensure_installed = {
        "shfmt",
      },
    },
  },
}
