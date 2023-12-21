return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = User.table.merge_options {
      ensure_installed = {
        "gitcommit",
        "gitignore",
        "git_config",
        "git_rebase",
        "gitattributes",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = User.table.merge_options {
      formatters_by_ft = {
        ["gitcommit"] = { "cspell" },
      },
    },
  },
}
