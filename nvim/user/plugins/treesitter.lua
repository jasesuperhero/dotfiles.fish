return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
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
}
