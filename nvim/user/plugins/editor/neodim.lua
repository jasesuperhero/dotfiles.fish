return {
  "zbirenbaum/neodim",
  event = "User AstroFile",
  config = function()
    require("neodim").setup {
      alpha = 0.75,
      blend_color = "#000000",
      update_in_insert = {
        enable = true,
        delay = 100,
      },
      hide = {
        virtual_text = true,
        signs = true,
        underline = true,
      },
    }
  end,
}
