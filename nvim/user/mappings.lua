local astro_utils = require "astronvim.utils"

local mappings = {
  n = {
    -- disable default bindings
    ["<C-Down>"] = false,
    ["<C-Left>"] = false,
    ["<C-Right>"] = false,
    ["<C-Up>"] = false,
    ["<leader>th"] = false,
    ["<leader>tp"] = false,
    ["<leader>tu"] = false,
    ["<leader>tv"] = false,
    -- lsp
    ["<leader>uD"] = { function() require("lsp_lines").toggle() end, desc = "Toggle LSP lines" },
    -- resize with arrows
    ["<Up>"] = { function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
    ["<Down>"] = { function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
    ["<Left>"] = { function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
    ["<Right>"] = { function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
    -- Spectre replace words
    ["<leader>s"] = { desc = "󱁤 Find and replace" },
    ["<leader>ss"] = { function() require("spectre").open() end, desc = "Spectre" },
    ["<leader>sf"] = { function() require("spectre").open_file_search() end, desc = "Spectre (current file)" },
    ["<leader>sw"] = {
      function() require("spectre").open_visual { select_word = true } end,
      desc = "Spectre (current word)",
    },
    -- Grapple
    ["mt"] = { ":GrappleToggle<cr>", desc = "Tags current buffer" },
    ["mp"] = { ":GrapplePopup tags<cr>", desc = "Grapple tag popup menu" },
    -- Overseer code runner
    ["<leader>r"] = { desc = "󰢷 Code Runner" },
    ["<leader>rR"] = { "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
    ["<leader>ra"] = { "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
    ["<leader>rb"] = { "<cmd>OverseerBuild<cr>", desc = "Build" },
    ["<leader>rc"] = { "<cmd>OverseerClose<cr>", desc = "Close" },
    ["<leader>rd"] = { "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
    ["<leader>rl"] = { "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
    ["<leader>ro"] = { "<cmd>OverseerOpen<cr>", desc = "Open" },
    ["<leader>rq"] = { "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
    ["<leader>rr"] = { "<cmd>OverseerRun<cr>", desc = "Run" },
    ["<leader>rs"] = { "<cmd>OverseerSaveBundle<cr>", desc = "Save Bundle" },
    ["<leader>rt"] = { "<cmd>OverseerToggle<cr>", desc = "Toggle" },
    -- tests
    ["<leader>t"] = { desc = "󰙨 Neotest" },
    ["<leader>tF"] = {
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      desc = "Debug File",
    },
    ["<leader>tL"] = {
      "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>",
      desc = "Debug Last",
    },
    ["<leader>ta"] = {
      "<cmd>lua require('neotest').run.attach()<cr>",
      desc = "Test Attach",
    },
    ["<leader>tf"] = {
      "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
      desc = "Test File",
    },
    ["<leader>tl"] = {
      "<cmd>lua require('neotest').run.run_last()<cr>",
      desc = "Test Last",
    },
    ["<leader>tn"] = {
      "<cmd>lua require('neotest').run.run()<cr>",
      desc = "Test Nearest",
    },
    ["<leader>tN"] = {
      "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
      desc = "Debug Nearest",
    },
    ["<leader>to"] = {
      "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
      desc = "Test Output",
    },
    ["<leader>ts"] = {
      "<cmd>lua require('neotest').run.stop()<cr>",
      desc = "Test Stop",
    },
    ["<leader>tS"] = {
      "<cmd>lua require('neotest').summary.toggle()<cr>",
      desc = "Test Summary",
    },
    -- neogen
    ["<leader>a"] = { desc = "󰏫 Annotate" },
    ["<leader>a<cr>"] = { function() require("neogen").generate() end, desc = "Current" },
    ["<leader>ac"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" },
    ["<leader>af"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" },
    ["<leader>at"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" },
    ["<leader>aF"] = { function() require("neogen").generate { type = "file" } end, desc = "File" },
    -- Movement
    ["<Tab>"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers {
            sort_mru = true,
            ignore_current_buffer = true,
          }
        else
          astro_utils.notify "No other buffers open"
        end
      end,
      desc = "Switch Buffers",
    },
  },
  v = {
    ["<leader>s"] = { function() require("spectre").open_visual() end, desc = "Spectre" },
  },
}

return mappings
