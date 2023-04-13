-- auto stop auto-compiler if its running
vim.api.nvim_create_autocmd("VimLeave", {
  desc = "Stop running auto compiler",
  group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
  pattern = "*",
  callback = function() vim.fn.jobstart { "autocomp", vim.fn.expand "%:p", "stop" } end,
})

-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- auto hide tabline
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroBufsUpdated",
  group = vim.api.nvim_create_augroup("autohidetabline", { clear = true }),
  callback = function()
    local new_showtabline = #vim.t.bufs > 1 and 2 or 1
    if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
  end,
})

-- autohide diagnostics in insert and visual mode
vim.api.nvim_create_augroup("DiagnosticMode", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "i", "v" },
  group = "DiagnosticMode",
  callback = function()
    vim.diagnostic.config { virtual_lines = false }
    if vim.lsp.buf.server_ready() then vim.diagnostic.hide() end
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "n",
  group = "DiagnosticMode",
  callback = function()
    vim.diagnostic.config { virtual_lines = true }
    if vim.lsp.buf.server_ready() then vim.diagnostic.show() end
  end,
})

require "user.theme.watch_theme"
