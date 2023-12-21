return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = User.table.merge_options {
      ensure_installed = { "html" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = User.table.merge_options {
      formatters_by_ft = {
        ["html"] = { "prettierd" },
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
