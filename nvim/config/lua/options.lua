require "nvchad.options"

local opt = vim.opt
local o = vim.o

-- nvim-ufo requires foldlevel to be high so it can manage folds itself
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.foldcolumn = "1"

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
