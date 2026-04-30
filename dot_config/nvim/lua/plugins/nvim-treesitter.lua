return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"bash",
			"go",
			"javascript",
			"lua",
			"markdown",
			"markdown_inline",
			"regex",
			"typescript",
			"vim",
		}

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "bash", "go", "javascript", "lua", "markdown", "regex", "sh", "typescript", "vim" },
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
