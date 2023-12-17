local get_icon = require("astronvim.utils").get_icon

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = {
      "filesystem",
    },
    close_if_last_window = true,
    enable_diagnostics = true,
    enable_git_status = true,
    git_status_async = true,
    source_selector = {
      winbar = false,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = get_icon("FolderClosed", 1, true) .. "File" },
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
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
      position = "float",
      width = 40,
    },
  },
}
