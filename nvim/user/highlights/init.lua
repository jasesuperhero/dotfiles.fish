-- set highlights for all themes
-- use a function override to let us use lua to retrieve colors from highlight group
-- there is no default table so we don't need to put a parameter for this function
return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  -- get highlights from highlight groups
  local normal = get_hlgroup "Normal"
  local fg, bg = normal.fg, normal.bg
  local bg_alt = get_hlgroup("Visual").bg
  local green = get_hlgroup("String").fg
  local red = get_hlgroup("Error").fg
  -- return a table of highlights for telescope based on colors gotten from highlight groups
  return {
    TelescopeBorder = { fg = bg_alt, bg = bg },
    TelescopeNormal = { bg = bg },
    TelescopePreviewBorder = { fg = green, bg = bg },
    TelescopePreviewNormal = { bg = bg },
    TelescopePreviewTitle = { fg = bg, bg = green },
    TelescopePromptBorder = { fg = red, bg = bg },
    TelescopePromptNormal = { fg = fg, bg = bg },
    TelescopePromptPrefix = { fg = red, bg = bg },
    TelescopePromptTitle = { fg = bg, bg = red },
    TelescopeResultsBorder = { fg = red, bg = bg },
    TelescopeResultsNormal = { bg = bg },
    TelescopeResultsTitle = { fg = bg, bg = red },
  }
end
