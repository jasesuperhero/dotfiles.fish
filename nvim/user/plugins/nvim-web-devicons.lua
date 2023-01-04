local web_devicons = require("nvim-web-devicons")
local material_icon = require("nvim-material-icon")

web_devicons.setup({
  override = material_icon.get_icons(),
})
