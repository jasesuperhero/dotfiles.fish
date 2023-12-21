local wk = require "which-key"
local utils = require "config.utils"
local get_icon = utils.get_icon

wk.register {
  -- General
  ["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, "Move cursor down" },
  ["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, "Move cursor up" },
  ["<leader>w"] = { "<cmd>w<cr>", "Save" },
  ["<leader>q"] = { "<cmd>confirm q<cr>", "Quit" },
  ["<leader>Q"] = { "<cmd>confirm qall<cr>", "Quit all" },
  ["<leader>n"] = { "<cmd>enew<cr>", "New File" },
  ["<C-s>"] = { "<cmd>w!<cr>", "Force write" },
  ["<C-q>"] = { "<cmd>qa!<cr>", "Force quit" },
  ["|"] = { "<cmd>vsplit<cr>", "Vertical Split" },
  ["\\"] = { "<cmd>split<cr>", "Horizontal Split" },

  -- resize with arrows
  ["<Up>"] = { function() require("smart-splits").resize_up(2) end, "Resize split up" },
  ["<Down>"] = { function() require("smart-splits").resize_down(2) end, "Resize split down" },
  ["<Left>"] = { function() require("smart-splits").resize_left(2) end, "Resize split left" },
  ["<Right>"] = { function() require("smart-splits").resize_right(2) end, "Resize split right" },

  -- NvimTree
  ["<leader>e"] = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" },
  ["<leader>o"] = {
    function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
      else
        vim.cmd.Neotree "focus"
      end
    end,
    "Toggle Explorer Focus",
  },

  -- Telescope
  ["<leader>f"] = { name = get_icon("Search", 1) .. "Find" },
  ["<leader>f<CR>"] = { function() require("telescope.builtin").resume() end, "Resume previous search" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  ["<leader>fe"] = { "<cmd>Telescope file_browser<cr>", "File explorer" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
  ["<leader>f/"] = {
    function() require("telescope.builtin").current_buffer_fuzzy_find() end,
    "Find words in current buffer",
  },
  ["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, "Find word" },
  ["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, "Find Documentation" },
  ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", "Find TODOs" },
  ["<leader>fu"] = { "<cmd>Telescope undo<cr>", "Find in undo history" },
  ["<leader>fsc>"] = { "<cmd>Telescope commands<CR>", "Activates Telescope commands" },

  -- Telescope git search
  ["<leader>fg"] = { name = get_icon("Git", 1) .. "Git" },
  ["<leader>fgb"] = {
    function() require("telescope.builtin").git_branches { use_file_path = true } end,
    "Git branches",
  },
  ["<leader>fgc"] = {
    function() require("telescope.builtin").git_commits { use_file_path = true } end,
    "Git commits (repository)",
  },
  ["<leader>fgC"] = {
    function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
    "Git commits (current file)",
  },
  ["<leader>fgt"] = { function() require("telescope.builtin").git_status { use_file_path = true } end, "Git status" },

  -- Trouble
  ["<leader>xt"] = { ":TroubleToggle<CR>", "Toggle troubles" },

  -- Smart-splits
  ["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, "Move to left split" },
  ["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, "Move to below split" },
  ["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, "Move to above split" },
  ["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, "Move to right split" },

  -- Comments
  ["<leader>/"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    "Toggle comment line",
  },

  -- Neoterm
  ["<leader>t"] = { name = " " .. "Terminal" },
  ["<leader>tt"] = { ":NeotermToggle<CR>", "Toggle terminal" },
  ["<leader>tx"] = { ":NeotermExit<CR>", "Exit terminal" },

  -- Configuration
  ["<leader>pr"] = { ":so %<CR>", "Reload configuration" },
}

wk.register({
  ["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    "Toggle comment for selection",
  },
}, { mode = "v" })
