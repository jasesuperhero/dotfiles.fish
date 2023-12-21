-- local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = "300",
    }
  end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e",
})

-- Don"t auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

autocmd("Filetype", {
  pattern = {
    "xml",
    "html",
    "xhtml",
    "css",
    "scss",
    "javascript",
    "typescript",
    "yaml",
    "lua",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

-- Set colorcolumn
autocmd("Filetype", {
  pattern = { "python", "rst", "c", "cpp" },
  command = "set colorcolumn=80",
})

-- Enable spellcheck and auto text wrapping for markdown and git commit files
autocmd("Filetype", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "json5" },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- update foldcolumn ribbon colors
autocmd("ColorScheme", {
  callback = function()
    local util = require "config.utils"
    for i = 1, 8, 1 do
      vim.api.nvim_set_hl(0, "FoldCol" .. i, {
        bg = util.blend(
          string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).fg or 0),
          string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg or 0),
          0.125 * i
        ),
        fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg or 0,
      })
    end
  end,
})

autocmd({ "CursorHold" }, {
  callback = function() vim.wo.numberwidth = vim.wo.numberwidth end,
})
