return function()
  require "user.theme.watch_theme"

  -- Set up custom filetypes
  vim.filetype.add {
    extension = {
      fish = "fish",
      stencil = "swift",
    },
    filename = {
      ["Brewfile"] = "ruby",
    },
  }
end
