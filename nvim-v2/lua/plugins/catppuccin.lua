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

local function cmp_h(C)
  return {
    CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
    CmpItemKindKeyword = { fg = C.base, bg = C.red },
    CmpItemKindText = { fg = C.base, bg = C.teal },
    CmpItemKindMethod = { fg = C.base, bg = C.blue },
    CmpItemKindConstructor = { fg = C.base, bg = C.blue },
    CmpItemKindFunction = { fg = C.base, bg = C.blue },
    CmpItemKindFolder = { fg = C.base, bg = C.blue },
    CmpItemKindModule = { fg = C.base, bg = C.blue },
    CmpItemKindConstant = { fg = C.base, bg = C.peach },
    CmpItemKindField = { fg = C.base, bg = C.green },
    CmpItemKindProperty = { fg = C.base, bg = C.green },
    CmpItemKindEnum = { fg = C.base, bg = C.green },
    CmpItemKindUnit = { fg = C.base, bg = C.green },
    CmpItemKindClass = { fg = C.base, bg = C.yellow },
    CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
    CmpItemKindFile = { fg = C.base, bg = C.blue },
    CmpItemKindInterface = { fg = C.base, bg = C.yellow },
    CmpItemKindColor = { fg = C.base, bg = C.red },
    CmpItemKindReference = { fg = C.base, bg = C.red },
    CmpItemKindEnumMember = { fg = C.base, bg = C.red },
    CmpItemKindStruct = { fg = C.base, bg = C.blue },
    CmpItemKindValue = { fg = C.base, bg = C.peach },
    CmpItemKindEvent = { fg = C.base, bg = C.blue },
    CmpItemKindOperator = { fg = C.base, bg = C.blue },
    CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
    CmpItemKindCopilot = { fg = C.base, bg = C.teal },
  }
end

local function neotree_h(C)
  return {
    -- NeoTree
    NeoTreeNormal = { fg = C.text, bg = C.none },
    NeoTreeDirectoryName = { fg = C.text },
    NeoTreeDirectoryIcon = { fg = C.peach },
    NeoTreeFileName = { fg = C.text },
  }
end

local function dropbar_h(C)
  return {
    DropBarIconKindFolder = { fg = C.peach },
  }
end

return {
  "catppuccin/nvim",
  priority = 1000,
  config = function()
    require("catppuccin").setup {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        -- :h background
        light = "latte",
        dark = "mocha",
      },
      custom_highlights = function(colors) return table_merge(cmp_h(colors), neotree_h(colors), dropbar_h(colors)) end,
      highlight_overrides = {
        all = function(colors)
          return {
            CurSearch = { bg = colors.sky },
            IncSearch = { bg = colors.sky },
            CursorLineNr = { fg = colors.blue, style = { "bold" } },
            DashboardFooter = { fg = colors.overlay0 },
            TreesitterContextBottom = { style = {} },
            WinSeparator = { fg = colors.overlay0, style = { "bold" } },
            ["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
            ["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
            Headline = { style = { "bold" } },
            Headline1 = { fg = colors.blue, style = { "bold" } },
            Headline2 = { fg = colors.pink, style = { "bold" } },
            Headline3 = { fg = colors.lavender, style = { "bold" } },
            Headline4 = { fg = colors.green, style = { "bold" } },
            Headline5 = { fg = colors.peach, style = { "bold" } },
            Headline6 = { fg = colors.flamingo, style = { "bold" } },
            rainbow1 = { fg = colors.blue, style = { "bold" } },
            rainbow2 = { fg = colors.pink, style = { "bold" } },
            rainbow3 = { fg = colors.lavender, style = { "bold" } },
            rainbow4 = { fg = colors.green, style = { "bold" } },
            rainbow5 = { fg = colors.peach, style = { "bold" } },
            rainbow6 = { fg = colors.flamingo, style = { "bold" } },
          }
        end,
      },
      transparent_background = false,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        percentage = 0.15,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic", "bold" },
        loops = { "italic", "bold" },
        functions = { "bold" },
        keywords = { "bold" },
        strings = { "italic" },
        variables = { "italic" },
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = { "bold" },
      },
      integrations = {
        aerial = true,
        cmp = true,
        dap = { enabled = true, enable_ui = true },
        dropbar = {
          enabled = false,
          color_mode = false, -- enable color for kind's texts, not just kind's icons
        },
        fidget = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        indent_blankline = { enabled = true, colored_indent_levels = false },
        markdown = true,
        mason = true,
        mini = true,
        native_lsp = { enabled = true },
        neogit = true,
        neotest = true,
        neotree = true,
        notify = true,
        nvimtree = true,
        octo = true,
        overseer = true,
        symbols_outline = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        treesitter = true,
        treesitter_context = true,
        rainbow_delimiters = true,
        which_key = true,
      },
    }
  end,
}
