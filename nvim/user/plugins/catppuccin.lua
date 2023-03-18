return {
  "catppuccin/nvim",
  lazy = false,
  config = function() require("catppuccin").setup(require "user.plugins.configs.catppuccin") end,
}
