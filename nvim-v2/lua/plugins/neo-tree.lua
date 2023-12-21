return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  cmd = "Neotree",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>fe",
      function() require("neo-tree.command").execute { toggle = true, dir = User.root() } end,
      desc = "Explorer NeoTree (Root Dir)",
    },
    {
      "<leader>fE",
      function() require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() } end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    {
      "<leader>ge",
      function() require("neo-tree.command").execute { source = "git_status", toggle = true } end,
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      function() require("neo-tree.command").execute { source = "buffers", toggle = true } end,
      desc = "Buffer Explorer",
    },
  },
  deactivate = function() vim.cmd [[Neotree close]] end,
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.uv.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then require "neo-tree" end
    end
  end,
  opts = function()
    local utils = require "config.utils"
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
          { source = "filesystem", display_name = User.icons.fs.closed .. "File" },
        },
      },
      default_component_configs = {
        indent = { padding = 0 },
        icon = {
          folder_closed = User.icons.fs.closed,
          folder_open = User.icons.fs.opened,
          folder_empty = User.icons.fs.empty,
          folder_empty_open = User.icons.fs.empty_open,
          default = User.icons.fs.file,
        },
        modified = { symbol = User.icons.fs.modified },
        git_status = {
          symbols = {
            added = User.icons.git.added,
            deleted = User.icons.git.removed,
            modified = User.icons.git.modified,
            renamed = User.icons.git.renamed,
            untracked = User.icons.git.untracked,
            ignored = User.icons.git.ignored,
            unstaged = User.icons.git.unstaged,
            staged = User.icons.git.staged,
            conflict = User.icons.git.conflict,
          },
        },
      },
      commands = {
        system_open = function(state)
          -- TODO: just use vim.ui.open when dropping support for Neovim <0.10
          (vim.ui.open or require("config.utils").system_open)(state.tree:get_node():get_id())
        end,
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
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, seleect the next child
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          else -- if not a directory just open it
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
            utils.notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
          }, function(choice)
            local result = vals[choice]
            if result then
              utils.notify(("Copied: `%s`"):format(result))
              vim.fn.setreg("+", result)
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
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          F = "find_in_dir",
          O = "system_open",
          Y = "copy_selector",
          h = "parent_or_close",
          l = "child_or_open",
          o = "open",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
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
          never_show = {
            ".DS_Store",
            ".git",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_) vim.opt_local.signcolumn = "auto" end,
        },
      },
    }
  end,
}
