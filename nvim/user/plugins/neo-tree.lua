local get_icon = require("astronvim.utils").get_icon

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "mrbjarksen/neo-tree-diagnostics.nvim",
        dependencies = {
          "neo-tree.nvim",
        },
      },
    },
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "diagnostics",
      },
      close_if_last_window = true,
      enable_diagnostics = false,
      enable_git_status = true,
      git_status_async = true,
      source_selector = {
        -- winbar = true,
        content_layout = "center",
        tab_labels = {
          filesystem = get_icon "FolderClosed",
          buffers = get_icon "DefaultFile",
          git_status = get_icon "Git",
          diagnostics = get_icon "Diagnostic",
        },
      },
    },
  },
}
