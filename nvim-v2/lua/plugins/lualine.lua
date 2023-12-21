return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "VimEnter",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      local lualine = require "lualine"

      local conditions = {
        buffer_not_empty = function() return vim.fn.empty(vim.fn.expand "%:t") ~= 1 end,
        hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
        check_git_workspace = function()
          local filepath = vim.fn.expand "%:p:h"
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      lualine.setup {
        options = {
          component_separators = " ",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "aerial" } },
        },
        extensions = { "neo-tree", "lazy" },
        sections = {
          lualine_a = {
            {
              function() return User.icons.misc.vim_icon end,
              padding = { left = 1, right = 0 },
              separator = "",
            },
            "mode",
          },
          lualine_b = {
            "branch",
            {
              "diff",
              -- Is it me or the symbol for modified us really weird
              symbols = {
                added = User.icons.git.added,
                modified = User.icons.git.modified,
                removed = User.icons.git.removed,
              },
              cond = conditions.hide_in_width,
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = User.icons.diagnostics.error,
                warn = User.icons.diagnostics.warn,
                hint = User.icons.diagnostics.hint,
                info = User.icons.diagnostics.info,
              },
            },
          },
          lualine_c = {},
          lualine_x = { "encoding" },
          lualine_y = { "progress" },
          lualine_z = {
            { "location", separator = "" },
            {
              function() return "" end,
              padding = { left = 0, right = 1 },
            },
          },
        },
      }
    end,
  },
}
