local lspkind = require "lspkind"
-- opts parameter is the default options table
-- the function is lazy loaded so cmp is able to be required
local cmp = require "cmp"

return {
  {
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" },
    opts = {
      -- modify the sources part of the options table
      sources = cmp.config.sources {
        { name = "nvim_lsp_signature_help", priority = 1250 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      },
      formatting = {
        fields = {
          "kind",
          "abbr",
          "menu",
        },
        format = lspkind.cmp_format {
          mode = "symbol", -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          preset = "codicons",

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function(_, vim_item)
            vim_item.menu = vim_item.kind

            return vim_item
          end,
        },
      },
      experimental = {
        native_menu = false,
        ghost_text = false,
      },
      window = {
        completion = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
        documentation = {
          max_width = 40,
          border = "solid",
        },
      },
      view = {
        entries = {
          name = "custom",
          selection_order = "near_cursor",
        },
      },
      completion = {
        keyword_length = 3,
      },
    },
    dependencies = {
      {
        "hrsh7th/cmp-cmdline",
        dependencies = { "nvim-cmp" },
        config = function()
          -- configure mappings for cmdline
          local fallback_func = function(func)
            return function(fallback)
              if cmp.visible() then
                cmp[func]()
              else
                fallback()
              end
            end
          end
          local mappings = cmp.mapping.preset.cmdline {
            ["<C-j>"] = { c = fallback_func "select_next_item" },
            ["<C-k>"] = { c = fallback_func "select_prev_item" },
          }

          -- `/` cmdline setup.
          local buffer = {
            mapping = mappings,
            sources = {
              { name = "buffer" },
            },
          }
          cmp.setup.cmdline("/", buffer)
          cmp.setup.cmdline("?", buffer)

          -- `:` cmdline setup.
          cmp.setup.cmdline(":", {
            mapping = mappings,
            sources = cmp.config.sources({
              { name = "path" },
            }, {
              {
                name = "cmdline",
                option = {
                  ignore_cmds = { "Man", "!" },
                },
              },
            }),
          })
        end,
      },
      {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        dependencies = { "nvim-cmp" },
      },
    },
  },
}
