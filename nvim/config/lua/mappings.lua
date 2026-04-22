require "nvchad.mappings"

local map = vim.keymap.set

-- ─── NvChad nvim-tree overrides (replaced by neo-tree) ────────────────────
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "󰙅 Toggle NeoTree" })
map("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "󰙅 Focus NeoTree" })

-- ─── Existing ─────────────────────────────────────────────────────────────
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ─── Better j/k for wrapped lines ─────────────────────────────────────────
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- ─── Buffers ──────────────────────────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = " Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = " Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = " Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = " Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "󰬉 Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "󰬉 Switch to Other Buffer" })

-- ─── Search ───────────────────────────────────────────────────────────────
-- Saner n/N — always forward/backward regardless of search direction
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = " Next Search Result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = " Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = " Prev Search Result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = " Prev Search Result" })

-- Redraw, clear hlsearch, diff update
map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>",
  { desc = "󰱶 Redraw / Clear hlsearch / Diff Update" }
)

-- ─── Save ─────────────────────────────────────────────────────────────────
map({ "n" }, "<leader>w", "<cmd>w<cr>", { desc = " Save File" })

-- ─── Insert undo break-points ─────────────────────────────────────────────
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- ─── Diagnostics ──────────────────────────────────────────────────────────
local function diag_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go { severity = severity } end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = " Line Diagnostics" })
map("n", "]d", diag_goto(true), { desc = " Next Diagnostic" })
map("n", "[d", diag_goto(false), { desc = " Prev Diagnostic" })
map("n", "]e", diag_goto(true, "ERROR"), { desc = " Next Error" })
map("n", "[e", diag_goto(false, "ERROR"), { desc = " Prev Error" })
map("n", "]w", diag_goto(true, "WARN"), { desc = " Next Warning" })
map("n", "[w", diag_goto(false, "WARN"), { desc = " Prev Warning" })

-- ─── Terminal ─────────────────────────────────────────────────────────────
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = " Enter Normal Mode" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = " Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- ─── Windows ──────────────────────────────────────────────────────────────
map("n", "<leader>ww", "<C-W>p", { desc = "󱂀 Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "󰖭 Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "󰤻 Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "󰤼 Split Window Right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "󰤻 Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "󰤼 Split Window Right", remap = true })
