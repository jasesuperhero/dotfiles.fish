-- opts parameter is the default options table
-- the function is lazy loaded so cmp is able to be required
local cmp = require "cmp"

return {
  {
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" },
    opts = require "user.plugins.editor.configs.cmp",
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
