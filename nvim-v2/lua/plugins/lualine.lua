return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      local lualine = require "lualine"
      local utils = require "config.utils"
      local get_icon = utils.get_icon

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
        },
        sections = {
          lualine_a = {
            {
              function() return get_icon "VimIcon" end,
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
                added = get_icon("GitAdd", 1),
                modified = get_icon("GitChange", 1),
                removed = get_icon("GitDelete", 1),
              },
              cond = conditions.hide_in_width,
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = get_icon("DiagnosticError", 1),
                warn = get_icon("DiagnosticWarn", 1),
                info = get_icon("DiagnosticsInfo", 1),
              },
            },
          },
          lualine_c = {},
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
