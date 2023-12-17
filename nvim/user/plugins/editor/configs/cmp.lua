-- opts parameter is the default options table
-- the function is lazy loaded so cmp is able to be required
local cmp = require "cmp"
local border = require "user.util.border"

local cmp_ui = {
  icons = true,
  lspkind_text = true,
  style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
  border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
  selected_item_bg = "colored", -- colored / simple
}
local cmp_style = cmp_ui.style

local field_arrangement = {
  atom = { "kind", "abbr", "menu" },
  atom_colored = { "kind", "abbr", "menu" },
}

local formatting_style = {
  -- default fields order i.e completion word + item.kind + item.kind icons
  fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },
  format = function(entry, vim_item)
    local kind = require("lspkind").cmp_format {
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
    }(entry, vim_item)
    local strings = vim.split(kind.kind, "%s", { trimempty = true })
    kind.kind = " " .. (strings[1] or "") .. " "
    kind.menu = "    (" .. (strings[2] or "") .. ")"

    return kind
  end,
}

local options = {
  completion = {
    completeopt = "menu,menuone",
  },
  window = {
    completion = {
      border = border.default[vim.g.border],
      side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
      winhighlight = "Normal:Normal,CursorLine:Visual,Search:None",
      scrolloff = 0,
      col_offset = 0,
      scrollbar = false,
    },
    documentation = {
      border = border.default[vim.g.border],
      winhighlight = "Normal:Normal",
    },
  },
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  formatting = formatting_style,
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
  performance = {
    debounce = 300,
    throttle = 120,
    fetching_timeout = 100,
  },
  experimental = {
    ghost_text = true,
  },
}

if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then options.window.completion.border = border "CmpBorder" end

return options
