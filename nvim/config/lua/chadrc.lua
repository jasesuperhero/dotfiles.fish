-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "catppuccin-latte" },
  hl_override = {
    NormalFloat = { bg = "none" },
    FloatBorder = { bg = "none" },
    TelescopeNormal = { bg = "darker_black" },
    TelescopePromptNormal = { bg = "black2" },
  },
}

-- M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    enabled = false,
  },
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
  telescope = { style = "bordered" },
}

return M
