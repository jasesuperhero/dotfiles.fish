local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
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

-- Auto format on save using the attached (optionally filtered) language servere clients
-- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
autocmd("BufWritePre", {
  pattern = "",
  command = ":silent lua vim.lsp.buf.format()",
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
