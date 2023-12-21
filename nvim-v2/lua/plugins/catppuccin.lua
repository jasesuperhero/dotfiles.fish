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
    CmpItemKindClass = { fg = C.base, bg = C.yellow },
    CmpItemKindColor = { fg = C.base, bg = C.red },
    CmpItemKindConstant = { fg = C.base, bg = C.peach },
    CmpItemKindConstructor = { fg = C.base, bg = C.blue },
    CmpItemKindCopilot = { fg = C.base, bg = C.teal },
    CmpItemKindEnum = { fg = C.base, bg = C.green },
    CmpItemKindEnumMember = { fg = C.base, bg = C.red },
    CmpItemKindEvent = { fg = C.base, bg = C.blue },
    CmpItemKindField = { fg = C.base, bg = C.green },
    CmpItemKindFile = { fg = C.base, bg = C.blue },
    CmpItemKindFolder = { fg = C.base, bg = C.blue },
    CmpItemKindFunction = { fg = C.base, bg = C.blue },
    CmpItemKindInterface = { fg = C.base, bg = C.yellow },
    CmpItemKindKeyword = { fg = C.base, bg = C.red },
    CmpItemKindMethod = { fg = C.base, bg = C.blue },
    CmpItemKindModule = { fg = C.base, bg = C.blue },
    CmpItemKindOperator = { fg = C.base, bg = C.blue },
    CmpItemKindProperty = { fg = C.base, bg = C.green },
    CmpItemKindReference = { fg = C.base, bg = C.red },
    CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
    CmpItemKindStruct = { fg = C.base, bg = C.blue },
    CmpItemKindText = { fg = C.base, bg = C.teal },
    CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
    CmpItemKindUnit = { fg = C.base, bg = C.green },
    CmpItemKindValue = { fg = C.base, bg = C.peach },
    CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
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
    DropBarIconKindArray = { fg = C.peach, bg = C.none },
    DropBarIconKindBoolean = { fg = C.peach, bg = C.none },
    DropBarIconKindBreakStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindCall = { fg = C.blue, bg = C.none },
    DropBarIconKindCaseStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindClass = { fg = C.yellow, bg = C.none },
    DropBarIconKindConstant = { fg = C.peach, bg = C.none },
    DropBarIconKindConstructor = { fg = C.blue, bg = C.none },
    DropBarIconKindContinueStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindDeclaration = { fg = C.blue, bg = C.none },
    DropBarIconKindDelete = { fg = C.blue, bg = C.none },
    DropBarIconKindDoStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindElseStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindEnum = { fg = C.green, bg = C.none },
    DropBarIconKindEnumMember = { fg = C.red, bg = C.none },
    DropBarIconKindEvent = { fg = C.blue, bg = C.none },
    DropBarIconKindField = { fg = C.green, bg = C.none },
    DropBarIconKindFile = { fg = C.peach, bg = C.none },
    DropBarIconKindFolder = { fg = C.peach, bg = C.none },
    DropBarIconKindFunction = { fg = C.blue, bg = C.none },
    DropBarIconKindIfStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindInterface = { fg = C.yellow, bg = C.none },
    DropBarIconKindKeyword = { fg = C.red, bg = C.none },
    DropBarIconKindList = { fg = C.peach, bg = C.none },
    DropBarIconKindMacro = { fg = C.peach, bg = C.none },
    DropBarIconKindH1Marker = { link = "markdownH1" },
    DropBarIconKindH2Marker = { link = "markdownH2" },
    DropBarIconKindH3Marker = { link = "markdownH3" },
    DropBarIconKindH4Marker = { link = "markdownH4" },
    DropBarIconKindH5Marker = { link = "markdownH5" },
    DropBarIconKindH6Marker = { link = "markdownH6" },
    DropBarIconKindMethod = { fg = C.blue, bg = C.none },
    DropBarIconKindModule = { fg = C.blue, bg = C.none },
    DropBarIconKindNamespace = { fg = C.blue, bg = C.none },
    DropBarIconKindNull = { fg = C.blue, bg = C.none },
    DropBarIconKindNumber = { fg = C.blue, bg = C.none },
    DropBarIconKindObject = { fg = C.blue, bg = C.none },
    DropBarIconKindOperator = { fg = C.blue, bg = C.none },
    DropBarIconKindPackage = { fg = C.yellow, bg = C.none },
    DropBarIconKindProperty = { fg = C.green, bg = C.none },
    DropBarIconKindReference = { fg = C.red, bg = C.none },
    DropBarIconKindRepeat = { fg = C.mauve, bg = C.none },
    DropBarIconKindScope = { fg = C.mauve, bg = C.none },
    DropBarIconKindSpecifier = { fg = C.blue, bg = C.none },
    DropBarIconKindStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindString = { fg = C.blue, bg = C.none },
    DropBarIconKindStruct = { fg = C.blue, bg = C.none },
    DropBarIconKindSwitchStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindType = { fg = C.green, bg = C.none },
    DropBarIconKindTypeParameter = { fg = C.blue, bg = C.none },
    DropBarIconKindUnit = { fg = C.yellow, bg = C.none },
    DropBarIconKindValue = { fg = C.peach, bg = C.none },
    DropBarIconKindVariable = { fg = C.flamingo, bg = C.none },
    DropBarIconKindWhileStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindForStatement = { fg = C.blue, bg = C.none },
    DropBarIconKindIdentifier = { fg = C.blue, bg = C.none },
    DropBarIconKindPair = { fg = C.blue, bg = C.none },
    DropBarIconKindTerminal = { fg = C.blue, bg = C.none },
    DropBarIconUIIndicator = { fg = C.text, bg = C.none },
    DropBarIconUIPickPivot = { fg = C.text, bg = C.none },
    DropBarIconUISeparator = { fg = C.text, bg = C.none },
    DropBarIconUISeparatorMenu = { fg = C.blue, bg = C.none },
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
        dap = true,
        dap_ui = true,
        dashboard = true,
        dropbar = {
          enabled = true,
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
