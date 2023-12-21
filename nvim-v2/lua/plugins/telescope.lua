return {
  {
    -- Fuzzy finder.
    -- The default key bindings to find files will use Telescope's
    -- `find_files` or `git_files` depending on whether the
    -- directory is a git repo.
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader>:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
      },
      {
        "<leader><space>",
        User.telescope "files",
        desc = "Find Files (Root Dir)",
      },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fc",
        User.telescope.config_files(),
        desc = "Find Config File",
      },
      {
        "<leader>ff",
        User.telescope "files",
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>fF",
        User.telescope("files", { cwd = false }),
        desc = "Find Files (cwd)",
      },
      {
        "<leader>fg",
        "<cmd>Telescope git_files<cr>",
        desc = "Find Files (git-files)",
      },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", User.telescope("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      -- git
      { "<leader>fg", desc = User.icons.git.git .. "Git" },
      { "<leader>fgc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      {
        "<leader>fgC",
        function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
        desc = "Commits (current file)",
      },
      { "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      {
        "<leader>fgb",
        function() require("telescope.builtin").git_branches { use_file_path = true } end,
        desc = "Branches",
      },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      {
        "<leader>sc",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
      },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      {
        "<leader>sd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document Diagnostics",
      },
      {
        "<leader>sD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace Diagnostics",
      },
      {
        "<leader>sg",
        User.telescope "live_grep",
        desc = "Grep (Root Dir)",
      },
      { "<leader>sG", User.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>sw",
        User.telescope("grep_string", { word_match = "-w" }),
        desc = "Word (Root Dir)",
      },
      { "<leader>sW", User.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      {
        "<leader>sw",
        User.telescope "grep_string",
        mode = "v",
        desc = "Selection (Root Dir)",
      },
      {
        "<leader>sW",
        User.telescope("grep_string", { cwd = false }),
        mode = "v",
        desc = "Selection (cwd)",
      },
      {
        "<leader>uC",
        User.telescope("colorscheme", { enable_preview = true }),
        desc = "Colorscheme with Preview",
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols {
            symbols = User.get_kind_filter(),
          }
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols {
            symbols = User.get_kind_filter(),
          }
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = function()
      local actions = require "telescope.actions"
      local fb_actions = require("telescope").extensions.file_browser.actions

      local open_with_trouble = function(...) return require("trouble.providers.telescope").open_with_trouble(...) end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require "telescope.actions.state"
        local line = action_state.get_current_line()
        User.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require "telescope.actions.state"
        local line = action_state.get_current_line()
        User.telescope("find_files", { hidden = true, default_text = line })()
      end

      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ❯ ",
          entry_prefix = "   ",
          multi_icon = "+ ",
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git",
          },
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = {
            width = 0.90,
            height = 0.85,
            preview_cutoff = 120,
            horizontal = {
              preview_width = 0.6,
            },
            vertical = {
              width = 0.9,
              height = 0.95,
              preview_height = 0.5,
            },
            flex = {
              horizontal = {
                preview_width = 0.9,
              },
            },
          },
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then return win end
            end
            return 0
          end,
          extensions = {
            media_files = {
              filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
              find_cmd = "rg",
            },
            file_browser = {
              mappings = {
                i = {
                  ["<C-z>"] = fb_actions.toggle_hidden,
                },
                n = {
                  z = fb_actions.toggle_hidden,
                },
              },
            },
          },
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,

              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,

              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      telescope.load_extension "fzf"
      telescope.load_extension "notify"
      telescope.load_extension "file_browser"
      telescope.load_extension "undo"
      telescope.load_extension "media_files"
    end,
  },
}
