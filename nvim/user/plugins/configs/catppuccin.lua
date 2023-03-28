local function table_merge(...)
  local tables_to_merge = { ... }
  assert(#tables_to_merge > 1, "There should be at least two tables to merge them")

  for k, t in ipairs(tables_to_merge) do
    assert(type(t) == "table", string.format("Expected a table as function parameter %d", k))
  end

  local result = tables_to_merge[1]

  for i = 2, #tables_to_merge do
    local from = tables_to_merge[i]
    for k, v in pairs(from) do
      if type(k) == "number" then
        table.insert(result, v)
      elseif type(k) == "string" then
        if type(v) == "table" then
          result[k] = result[k] or {}
          result[k] = table_merge(result[k], v)
        else
          result[k] = v
        end
      end
    end
  end

  return result
end

local function cmp_h(colors)
  return {
    -- item foramat
    CmpItemAbbr = { fg = colors.text },
    CmpItemAbbrDeprecated = { fg = colors.overlay0, style = { "strikethrough" } },
    CmpItemAbbrMatch = { fg = colors.blue },
    CmpItemAbbrMatchFuzzy = { fg = colors.text, style = { "bold" } },
    CmpItemKind = { fg = colors.blue },
    CmpItemMenu = { fg = colors.text },
    -- kind support
    CmpItemKindSnippet = { fg = colors.mauve, bg = colors.surface0 },
    CmpItemKindKeyword = { fg = colors.red, bg = colors.surface0 },
    CmpItemKindText = { fg = colors.teal, bg = colors.surface0 },
    CmpItemKindMethod = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindConstructor = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindFunction = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindFolder = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindModule = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindConstant = { fg = colors.peach, bg = colors.surface0 },
    CmpItemKindField = { fg = colors.green, bg = colors.surface0 },
    CmpItemKindProperty = { fg = colors.green, bg = colors.surface0 },
    CmpItemKindEnum = { fg = colors.green, bg = colors.surface0 },
    CmpItemKindUnit = { fg = colors.green, bg = colors.surface0 },
    CmpItemKindClass = { fg = colors.yellow, bg = colors.surface0 },
    CmpItemKindVariable = { fg = colors.flamingo, bg = colors.surface0 },
    CmpItemKindFile = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindInterface = { fg = colors.yellow, bg = colors.surface0 },
    CmpItemKindColor = { fg = colors.red, bg = colors.surface0 },
    CmpItemKindReference = { fg = colors.red, bg = colors.surface0 },
    CmpItemKindEnumMember = { fg = colors.red, bg = colors.surface0 },
    CmpItemKindStruct = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindValue = { fg = colors.peach, bg = colors.surface0 },
    CmpItemKindEvent = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindOperator = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindTypeParameter = { fg = colors.blue, bg = colors.surface0 },
    CmpItemKindCopilot = { fg = colors.teal, bg = colors.surface0 },
  }
end

local function neotree_h(colors)
  return {
    -- NeoTree
    NeoTreeNormal = { fg = colors.text, bg = colors.none },
    NeoTreeDirectoryName = { fg = colors.text },
    NeoTreeDirectoryIcon = { fg = colors.peach },
    NeoTreeFileName = { fg = colors.text },
  }
end

return {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {
    -- :h background
    light = "latte",
    dark = "mocha",
  },
  custom_highlights = function(colors) return table_merge(cmp_h(colors), neotree_h(colors)) end,
  transparent_background = false,
  term_colors = true,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic", "bold" },
    loops = { "italic", "bold" },
    functions = { "bold" },
    keywords = { "bold" },
    strings = { "underline" },
    variables = { "italic" },
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = { "bold" },
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
    ts_rainbow2 = true,
    which_key = true,
    neotest = true,
    overseer = true,
  },
}
