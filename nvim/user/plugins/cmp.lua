local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

return {
  experimental = {
    ghost_text = true,
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  window = {
    documentation = {
      max_width = 40,
      border = "solid",
    },
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
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
    format = function(_, vim_item)
      vim_item.menu = vim_item.kind
      vim_item.kind = lspkind.presets.default[vim_item.kind]

      return vim_item
    end,
  },
}
