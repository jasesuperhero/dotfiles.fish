require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Highlight text on yank
autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 } end,
})

-- Auto-create intermediate directories when saving a file
autocmd("BufWritePre", {
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Don't auto-insert comment leader on newline
autocmd("BufEnter", {
  callback = function() vim.opt_local.formatoptions:remove { "c", "r", "o" } end,
})

-- Spell check and soft wrap for prose filetypes
autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for JSON (prevent quotes being hidden)
autocmd("FileType", {
  pattern = { "json", "jsonc", "json5" },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

-- Color column guide for Python and C/C++
autocmd("FileType", {
  pattern = { "python", "rst", "c", "cpp" },
  callback = function() vim.opt_local.colorcolumn = "80" end,
})

-- NeoTree highlights (base46 doesn't manage these, so we set them manually)
local function set_neotree_highlights()
  local ok, base46 = pcall(require, "base46")
  if not ok then return end
  local c = base46.get_theme_tb "base_30"
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = c.white, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { fg = c.white, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = c.white })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = c.orange })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = c.white })
end

autocmd("User", { pattern = "FilePost", once = true, callback = set_neotree_highlights })
autocmd("ColorScheme", { callback = set_neotree_highlights })
