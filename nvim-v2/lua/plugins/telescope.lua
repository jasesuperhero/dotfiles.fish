return {
  {
    -- Telescope
    -- Find, Filter, Preview, Pick. All lua, all the time.
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "debugloop/telescope-undo.nvim",
      "nvim-neorg/neorg-telescope",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-hop.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    cmd = "Telescope",
    config = function(opts)
      local telescope = require "telescope"
      local actions = require "telescope.actions"
      local utils = require "config.utils"
      local get_icon = utils.get_icon
      local fb_actions = require("telescope").extensions.file_browser.actions

      telescope.setup {
        defaults = {
          git_worktrees = vim.g.git_worktrees,
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
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = { q = actions.close },
          },
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
        },
      }
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      telescope.load_extension "fzf"

      telescope.load_extension "notify"
      telescope.load_extension "file_browser"
      telescope.load_extension "undo"
      telescope.load_extension "media_files"

      local opts = { noremap = true, silent = true }
      local builtin = require "telescope.builtin"
      vim.keymap.set(
        "n",
        "<C-p>",
        function()
          builtin.find_files {
            find_command = { "rg", "--hidden", "--files", "--smart-case", "--glob=!.git" },
          }
        end,
        opts
      )
      vim.keymap.set(
        "n",
        "<leader>fo",
        function()
          builtin.oldfiles {
            only_cwd = true,
          }
        end,
        opts
      )
      vim.keymap.set("n", "<leader>fw", builtin.live_grep, opts)
      vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
      vim.keymap.set("n", "<leader>fc", builtin.commands, opts)
      vim.keymap.set("n", "<leader>fr", builtin.resume, opts)
      vim.keymap.set("n", "<leader>fq", builtin.quickfix, opts)
      vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, opts)
      vim.keymap.set("n", "<leader>xx", builtin.diagnostics, opts)
      -- vim.keymap.set("n", "<leader>ghi", telescope.extensions.gh.issues, opts)
      -- vim.keymap.set("n", "<leader>fj", telescope.extensions.harpoon.marks, opts)
    end,
  },
}
