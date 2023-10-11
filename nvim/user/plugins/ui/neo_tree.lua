local get_icon = require("astronvim.utils").get_icon

return {
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
      statusline = false, -- toggle to show selector on statusline
      winbar = false,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = get_icon("FolderClosed", 1, true) .. "F" },
        { source = "buffers", display_name = get_icon("DefaultFile", 1, true) .. "B" },
        { source = "git_status", display_name = get_icon("Git", 1, true) .. "G" },
        { source = "diagnostics", display_name = get_icon("Diagnostic", 1, true) .. "D" },
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
      width = 40,
    },
  },
}
