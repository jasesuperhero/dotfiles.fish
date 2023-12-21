return {
  {
    "stevearc/aerial.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local icons = vim.deepcopy(User.icons.kinds)

      -- HACK: fix lua's weird choice for `Package` for control
      -- structures like if/else/for/etc.
      icons.lua = { Package = icons.Control }

      local filter_kind = false
      if User.kind_filter then
        filter_kind = assert(vim.deepcopy(User.kind_filter))
        filter_kind._ = filter_kind.default
        filter_kind.default = nil
      end
      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        layout = {
          resize_to_content = false,
          min_width = 28,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        icons = icons,
        filter_kind = filter_kind,
        guides = {
          mid_item = "├╴",
          last_item = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
        keymaps = {
          ["[y"] = "actions.prev",
          ["]y"] = "actions.next",
          ["[Y"] = "actions.prev_up",
          ["]Y"] = "actions.next_up",
          ["{"] = false,
          ["}"] = false,
          ["[["] = false,
          ["]]"] = false,
        },
      }
      return opts
    end,
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
  },
  -- Telescope integration
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      User.on_load("telescope.nvim", function() require("telescope").load_extension "aerial" end)
    end,
    keys = {
      {
        "<leader>ss",
        "<cmd>Telescope aerial<cr>",
        desc = "Goto Symbol (Aerial)",
      },
    },
  },
}
