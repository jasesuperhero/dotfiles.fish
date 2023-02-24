return {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  custom_highlights = function(colors)
    return {
      NeoTreeNormal = { fg = colors.text, bg = colors.none },
      NeoTreeDirectoryName = { fg = colors.surface2 },
      NeoTreeDirectoryIcon = { fg = colors.peach },
    }
  end,
  transparent_background = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    cmp = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
    fidget = true,
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    markdown = true,
    mason = true,
    native_lsp = { enabled = true },
    neogit = true,
    neotree = true,
    notify = true,
    nvimtree = true,
    symbols_outline = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    which_key = true,
    bufferline = true,
  },
}
