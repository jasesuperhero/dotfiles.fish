return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    indent = { char = "▏" },
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}
