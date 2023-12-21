return {
  {
    -- Floating terminal
    "itmecho/neoterm.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      {
        "<leader>tt",
        ":NeotermToggle<CR>",
        desc = "Toggle terminal",
      },
      {
        "<leader>tx",
        ":NeotermExit<CR>",
        desc = "Exit terminal",
      },
    },
    opts = {
      clear_on_run = true, -- run clear command before user specified commands
      mode = "horizontal", -- vertical/horizontal/fullscreen
      noinsert = false, -- disable entering insert mode when opening the neoterm window
    },
  },
}
