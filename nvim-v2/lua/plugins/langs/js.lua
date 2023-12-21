return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = User.table.merge_options {
      ensure_installed = { "javascript" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = User.table.merge_options {
      formatters_by_ft = {
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = User.table.merge_options {
      ensure_installed = {
        "prettierd",
      },
    },
  },
}
