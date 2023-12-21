return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = User.table.merge_options {
      formatters_by_ft = {
        ["less"] = { "prettierd" },
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
