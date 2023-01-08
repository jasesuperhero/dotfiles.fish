local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

return {
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  window = {
    completion = {
      winhighlight = "Normal:NormalFloat,NormalFloat:Pmenu,Pmenu:NormalFloat",
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
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
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
}
