return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "User AstroFile",
  keys = { { "s", mode = "v" }, "<C-g>s", "<C-g>S", "ys", "yss", "yS", "cs", "ds" },
  config = function()
    require("nvim-surround").setup {
      move_cursor = true,
      keymaps = { visual = "s" },
    }
  end,
}
