return {
  "j-hui/fidget.nvim",
  lazy = true,
  event = "LspAttach",
  opts = {
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
  },
}
