local M = {}

local override = require("custom.override")
local userPlugins = require("custom.plugins")

M.ui = {
	theme = "chadracula",
}

M.plugins = {
	user = userPlugins,
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},

		statusline = {
			separator_style = "arrow",
		},
	},

	override = {
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
		["nvim-treesitter/nvim-treesitter"] = override.treesitter,
		["lukas-reineke/indent-blankline.nvim"] = override.blankline,
	},
}

M.options = {
	user = function()
		require("custom.options")
	end,
}

M.mappings = require("custom.mappings")

return M
