require "nvchad.options"

-- Fold column icons (must come after nvchad.options which resets fillchars)
vim.opt.fillchars:append {
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
  stl = " ",
}

local opt = vim.opt
local o = vim.o

-- Line numbers
o.relativenumber = true

-- Scrolling
o.scrolloff = 18
o.sidescrolloff = 3

-- Indentation
o.shiftround = true

-- Display
o.wrap = false
o.cmdheight = 0
opt.list = true
opt.listchars = {
  tab = "┊ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "×",
}

-- Performance
o.timeoutlen = 250

-- Files
o.swapfile = false

-- Persistent undo
o.undolevels = 1000
o.undoreload = 10000

-- Rounded borders for LSP floating windows
local function with_border(handler)
  return function(err, result, ctx, config)
    return handler(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
  end
end
vim.lsp.handlers["textDocument/hover"] = with_border(vim.lsp.handlers["textDocument/hover"])
vim.lsp.handlers["textDocument/signatureHelp"] = with_border(vim.lsp.handlers["textDocument/signatureHelp"])
vim.diagnostic.config { float = { border = "rounded" } }
