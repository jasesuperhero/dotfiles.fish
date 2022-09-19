local M = {}

M.treesitter = {
	n = {
		["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "  find media" },
	},
}

M.hop = {
	n = {
		["<leader>jl"] = {
			"<cmd> HopLine <CR>",
			"[Hop] Go to line",
		},
		["<leader>jw"] = {
			"<cmd> HopWord <CR>",
			"[Hop] Go to word",
		},
	},
}

return M
