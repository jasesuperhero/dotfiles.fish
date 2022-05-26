return {

	["windwp/nvim-ts-autotag"] = {
		ft = { "html", "javascriptreact" },
		after = "nvim-treesitter",
		config = function()
			local present, autotag = pcall(require, "nvim-ts-autotag")

			if present then
				autotag.setup()
			end
		end,
	},

	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	["nvim-treesitter/playground"] = {
		cmd = "TSCaptureUnderCursor",
		config = function()
			require("nvim-treesitter.configs").setup()
		end,
	},

	["sindrets/diffview.nvim"] = {
		after = "plenary.nvim",
		config = function()
			require("custom.plugins.diffview")
		end,
	},

	["folke/trouble.nvim"] = {
		after = "nvim-web-devicons",
		config = function()
			require("custom.plugins.troubles")
		end,
	},

	["rcarriga/nvim-notify"] = {
		config = function()
			require("custom.plugins.notify")
		end,
	},

	["phaazon/hop.nvim"] = {
		config = function()
			require("hop").setup()
		end,
	},
}