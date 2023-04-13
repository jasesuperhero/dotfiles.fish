return {
  "nvim-neotest/neotest",
  keys = {
    {
      "<leader>tNF",
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      desc = "Debug File",
    },
    { "<leader>tNL", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
    { "<leader>tNa", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach" },
    { "<leader>tNf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "File" },
    { "<leader>tNl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "Last" },
    { "<leader>tNn", "<cmd>lua require('neotest').run.run()<cr>", desc = "Nearest" },
    { "<leader>tNN", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
    { "<leader>tNo", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
    { "<leader>tNs", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop" },
    { "<leader>tNS", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
  },
  dependencies = {
    "antoinemadec/FixCursorHold.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-vim-test",
    "nvim-treesitter/nvim-treesitter",
    "rouge8/neotest-rust",
    "vim-test/vim-test",
  },
  config = function()
    local opts = {
      adapters = {
        require "neotest-python" {
          dap = { justMyCode = false },
          python = ".venv/bin/python",
          runner = "unittest",
        },
        require "neotest-plenary",
        require "neotest-vim-test" {
          ignore_file_types = { "python", "vim", "lua" },
        },
        require "neotest-rust",
      },
      -- overseer.nvim
      consumers = {
        overseer = require "neotest.consumers.overseer",
      },
      overseer = {
        enabled = true,
        force_default = true,
      },
    }
    require("neotest").setup(opts)
  end,
}
