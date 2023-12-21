return {
  "Bekaboo/dropbar.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  opts = {
    -- Use the default of vim-easymotion
    bar = { pick = { pivots = "hjklasdfgyuiopqwertnmzxcvb" } },
    menu = {
      keymaps = {
        ["<Esc>"] = function()
          local menu = require("dropbar.api").get_current_dropbar_menu()
          if menu then menu:close(true) end
        end,
      },
    },
    general = {
      ---@type boolean|fun(buf: integer, win: integer): boolean
      enable = function(buf, win)
        return not vim.api.nvim_win_get_config(win).zindex
          and (vim.bo[buf].buftype == "" or vim.bo[buf].buftype == "terminal")
          and not vim.wo[win].diff
      end,
    },
    icons = {
      kinds = {
        symbols = User.icons.kinds,
      },
    },
  },
}
