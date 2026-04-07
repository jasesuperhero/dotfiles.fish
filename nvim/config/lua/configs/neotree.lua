return {
  open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
  auto_clean_after_session_restore = true,
  close_if_last_window = true,
  enable_diagnostics = true,
  enable_git_status = true,
  git_status_async = true,
  sources = { "filesystem" },
  source_selector = {
    winbar = true,
    content_layout = "center",
    sources = {
      { source = "filesystem", display_name = " File" },
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      folder_empty_open = "",
      default = "󰈙",
    },
    modified = { symbol = "" },
    git_status = {
      symbols = {
        added = " ",
        deleted = " ",
        modified = " ",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
  },
  commands = {
    system_open = function(state) vim.ui.open(state.tree:get_node():get_id()) end,
    parent_or_close = function(state)
      local node = state.tree:get_node()
      if (node.type == "directory" or node:has_children()) and node:is_expanded() then
        state.commands.toggle_node(state)
      else
        require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
      end
    end,
    child_or_open = function(state)
      local node = state.tree:get_node()
      if node.type == "directory" or node:has_children() then
        if not node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
        end
      else
        state.commands.open(state)
      end
    end,
    copy_selector = function(state)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local filename = node.name
      local modify = vim.fn.fnamemodify
      local vals = {
        ["BASENAME"] = modify(filename, ":r"),
        ["EXTENSION"] = modify(filename, ":e"),
        ["FILENAME"] = filename,
        ["PATH (CWD)"] = modify(filepath, ":."),
        ["PATH (HOME)"] = modify(filepath, ":~"),
        ["PATH"] = filepath,
        ["URI"] = vim.uri_from_fname(filepath),
      }
      local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
      if vim.tbl_isempty(options) then
        vim.notify("No values to copy", vim.log.levels.WARN)
        return
      end
      table.sort(options)
      vim.ui.select(options, {
        prompt = "Choose to copy to clipboard:",
        format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
      }, function(choice)
        if choice then
          local result = vals[choice]
          if result then
            vim.notify(("Copied: `%s`"):format(result))
            vim.fn.setreg("+", result)
          end
        end
      end)
    end,
    find_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      require("telescope.builtin").find_files {
        cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
      }
    end,
  },
  window = {
    position = "float",
    width = 40,
    mappings = {
      ["<space>"] = false,
      ["[b"] = "prev_source",
      ["]b"] = "next_source",
      F = "find_in_dir",
      O = "system_open",
      Y = "copy_selector",
      h = "parent_or_close",
      l = "child_or_open",
      o = "open",
    },
    fuzzy_finder_mappings = {
      ["<C-j>"] = "move_cursor_down",
      ["<C-k>"] = "move_cursor_up",
    },
  },
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      never_show = { ".DS_Store", ".git" },
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(_) vim.opt_local.signcolumn = "auto" end,
    },
  },
}
