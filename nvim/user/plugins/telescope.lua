return {
  "nvim-telescope/telescope.nvim",
  dependencies = { -- add a new dependency to telescope that is our new plugin
    "nvim-telescope/telescope-media-files.nvim",
  },
  opts = {
    extensions = {
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
        find_cmd = "rg",
      },
    },
  },
  config = function(plugin, opts)
    -- run the core AstroNvim configuration function with the options table
    require "plugins.configs.telescope"(plugin, opts)

    -- require telescope and load extensions as necessary
    local telescope = require "telescope"
    telescope.load_extension "media_files"
  end,
}
