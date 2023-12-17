return {
  "catppuccin/nvim",
  priority = 1000,
  config = function() require("catppuccin").setup(require "user.plugins.ui.configs.catppuccin") end,
}
