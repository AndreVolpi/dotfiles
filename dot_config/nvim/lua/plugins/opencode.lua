return {
	"sudo-tee/opencode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				anti_conceal = { enabled = false },
				file_types = { "markdown", "opencode_output" },
			},
			ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
		},
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("opencode").setup({
			preferred_picker = "telescope",
			preferred_completion = "nvim-cmp",
			questions = { use_vim_ui_select = true },
			input = {
				text = { wrap = true },
				auto_hide = true,
			},
		})
	end,
}
