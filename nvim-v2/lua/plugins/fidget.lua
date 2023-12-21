return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function()
    require("fidget").setup {
      progress = {
        display = {
          done_icon = "", -- Icon shown when all LSP progress tasks are complete
        },
      },
      -- Options related to integrating with other plugins
      integration = {
        ["nvim-tree"] = {
          enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
        },
      },
      notification = {
        window = {
          winblend = 0,
        },
      },
    }
  end,
}
