return function()
  require "user.theme.watch_theme"

  -- Set up custom filetypes
  vim.filetype.add {
    extension = {
      fish = "fish",
      stencil = "swift",
      kdl = "kdl",
    },
    filename = {
      ["Brewfile"] = "ruby",
    },
  }
end
