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
      enable_diagnostics = true,
      enable_git_status = true,
      git_status_async = true,
      source_selector = {
        winbar = false, -- toggle to show selector on winbar
        statusline = true, -- toggle to show selector on statusline
        content_layout = "center",
        tab_labels = {
          filesystem = get_icon "FolderClosed",
          buffers = get_icon "DefaultFile",
          git_status = get_icon "Git",
          diagnostics = get_icon "Diagnostic",
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = {
            ".DS_Store",
            ".git",
          },
        },
        mappings = {
          ["f"] = "filter_on_submit",
        },
      },
      window = {
        width = 30,
      },
    },
  },
}
