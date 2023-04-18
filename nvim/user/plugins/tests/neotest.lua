return {
  "nvim-neotest/neotest",
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
