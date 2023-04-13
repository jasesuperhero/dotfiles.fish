return {
  "mawkler/modicator.nvim",
  event = "User AstroFile",
  dependencies = "catppuccin/nvim", -- Add your colorscheme plugin here
  config = function()
    -- These are required for Modicator to work
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true

    local modicator = require "modicator"
    local status = require "astronvim.utils.status"
    local C = status.env.fallback_colors
    local get_hlgroup = require("astronvim.utils").get_hlgroup

    local HeirlineNormal = status.hl.lualine_mode("normal", C.blue)
    local HeirlineInsert = status.hl.lualine_mode("insert", C.green)
    local HeirlineVisual = status.hl.lualine_mode("visual", C.purple)
    local HeirlineReplace = get_hlgroup("HeirlineReplace", { bg = nil }).bg
      or status.hl.lualine_mode("replace", C.bright_red)
    local HeirlineCommand = get_hlgroup("HeirlineCommand", { bg = nil }).bg
      or status.hl.lualine_mode("command", C.bright_yellow)
    local HeirlineTerminal = get_hlgroup("HeirlineTerminal", { bg = nil }).bg
      or status.hl.lualine_mode("insert", HeirlineInsert)

    require("modicator").setup {
      -- Default options for bold/italic. You can override these individually
      -- for each mode if you'd like as seen below.
      defaults = {
        foreground = modicator.get_highlight_fg "CursorLineNr",
        background = modicator.get_highlight_bg "CursorLineNr",
        bold = true,
        italic = false,
      },
      -- Color and bold/italic options for each mode. You can add a bold and/or
      -- italic key pair to override the default highlight for a specific mode if
      -- you would like.
      modes = {
        ["n"] = {
          foreground = HeirlineNormal,
        },
        ["i"] = {
          foreground = HeirlineInsert,
        },
        ["v"] = {
          foreground = HeirlineVisual,
        },
        ["V"] = {
          foreground = HeirlineVisual,
        },
        [""] = { -- This symbol is the ^V character
          foreground = HeirlineVisual,
        },
        ["s"] = {
          foreground = modicator.get_highlight_fg "Keyword",
        },
        ["S"] = {
          foreground = modicator.get_highlight_fg "Keyword",
        },
        ["R"] = {
          foreground = modicator.get_highlight_fg "Title",
        },
        ["c"] = {
          foreground = modicator.get_highlight_fg "Constant",
        },
      },
    }
  end,
}
