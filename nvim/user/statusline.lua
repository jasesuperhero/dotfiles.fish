local status = require "astronvim.utils.status"

local M = {}

function M.mode_color(hl)
  local get_mode = vim.fn.mode()
  local mode = get_mode:lower()
  if mode == "n" then
    return hl.normal
  elseif mode == "i" or mode == "t" then
    return hl.insert
  elseif mode == "v" or mode == "" or mode == "s" then
    return hl.visual
  elseif mode == "r" then
    return hl.replace
  elseif mode == "c" then
    return hl.command
  end
end

function M.mode()
  local mode_text = status.env.modes[vim.fn.mode()][1]
  local get_mode = vim.fn.mode()
  local mode = get_mode:lower()
  local icon = "ﮊ "
  if mode == "n" then
    icon = " "
  elseif mode == "i" then
    icon = "ﲅ "
  elseif mode == "v" or mode == "" or mode == "s" then
    icon = " "
  elseif mode == "r" then
    icon = " "
  elseif mode == "c" or mode == "t" then
    icon = " "
  end
  return " " .. icon .. mode_text .. " "
end
