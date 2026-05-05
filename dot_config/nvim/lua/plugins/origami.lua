return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {
		useLspFoldsWithTreesitterFallback = { enabled = true },
		foldtext = {
			enabled = true,
			padding = {
				character = " ",
				width = 0,
				hlgroup = nil,
			},
			lineCount = {
				template = "↙ %d",
				hlgroup = "Comment",
			},
		},
		autoFold = {
			enabled = true,
			kinds = { "comment", "imports" },
		},
	},
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}

