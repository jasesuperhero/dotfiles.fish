return {
  "b0o/incline.nvim",
  lazy = true,
  event = "BufReadPre",
  keys = {
    {
      "<leader>uI",
      function() require("incline").toggle() end,
      desc = "Toggle Incline",
    },
  },
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  opts = {
    highlight = {
      --   groups = {
      --       InclineNormalNC = { default = true, group = "Comment" },
      --   },
    },
    window = {
      padding = 0,
      margin = { horizontal = 0, vertical = 0 },
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then filename = "[No Name]" end

      local devicons = require "nvim-web-devicons"
      local helpers = require "incline.helpers"
      local ft_icon, ft_color = devicons.get_icon_color(filename)

      return {
        ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
        " ",
        { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
        guibg = "Comment",
      }
    end,
  },
}
