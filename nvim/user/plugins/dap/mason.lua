return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    ensure_installed = {
      "python",
      "bash",
    },
  },
  config = function(_, opts)
    local mason_nvim_dap = require "mason-nvim-dap"
    mason_nvim_dap.setup(opts) -- run setup
  end,
}
