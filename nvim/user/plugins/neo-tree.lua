require "neo-tree"

vim.g.neo_tree_remove_legacy_commands = 1

return {
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
    winbar = true,
    content_layout = "center",
    tab_labels = {
      filesystem = astronvim.get_icon "FolderClosed",
      buffers = astronvim.get_icon "DefaultFile",
      git_status = astronvim.get_icon "Git",
      diagnostics = astronvim.get_icon "Diagnostic",
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = astronvim.get_icon "FolderClosed",
      folder_open = astronvim.get_icon "FolderOpen",
      folder_empty = astronvim.get_icon "FolderEmpty",
      default = astronvim.get_icon "DefaultFile",
    },
    diagnostics = {
      highlights = {
        hint = "DiagnosticHint",
        info = "DiagnosticInfo",
        warn = "DiagnosticWarn",
        error = "DiagnosticError",
      },
    },
    git_status = {
      symbols = {
        added = astronvim.get_icon "GitAdd",
        deleted = astronvim.get_icon "GitDelete",
        modified = astronvim.get_icon "GitChange",
        renamed = astronvim.get_icon "GitRenamed",
        untracked = astronvim.get_icon "GitUntracked",
        ignored = astronvim.get_icon "GitIgnored",
        unstaged = astronvim.get_icon "GitUnstaged",
        staged = astronvim.get_icon "GitStaged",
        conflict = astronvim.get_icon "GitConflict",
      },
    },
  },
  window = {
    width = 50,
    mappings = {
      ["<space>"] = false, -- disable space until we figure out which-key disabling
      o = "open",
      H = "prev_source",
      L = "next_source",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    group_empty_dirs = true,
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
      never_show = {
        ".DS_Store",
      },
    },
    window = {
      mappings = {
        O = "system_open",
        h = "toggle_hidden",
      },
    },
    commands = {
      system_open = function(state)
        astronvim.system_open(state.tree:get_node():get_id())
      end,
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(_)
        vim.opt_local.signcolumn = "auto"
      end,
    },
  },
}
