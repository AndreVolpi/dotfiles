return {
	"mason-org/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {},
	build = ":MasonUpdate",
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls", -- Bash, Sh, Zsh
				"docker_language_server", -- Docker
				"fish_lsp", -- Fish
				"gopls", -- Go
				"jsonls", -- JSON
				"lua_ls", -- Lua
				"marksman", -- Markdown
				"ts_ls", -- Node/TS
				"tofu_ls", -- OpenTofu
				"postgres_lsp", -- Postgres
				"pyright", -- Python
				"ruby_lsp", -- Ruby
				"taplo", -- TOML
				"yamlls", -- YAML
			},
			automatic_installation = true,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"beautysh", -- Bash, Sh, Zsh
				"gofumpt", -- Go
				"prettier", -- JS/TS/HTML/CSS/JSON/Markdown/YAML
				"stylua", -- Lua
				"black", -- Python
				"rubocop", -- Ruby

				-- Linters
				"hadolint", -- Docker
				"golangci-lint", -- Go
				"eslint_d", -- JS/TS
				"selene", -- Lua
				"tflint", -- OpenTofu
				"flake8", -- Python

				-- Extra utils
				"dotenv-linter", -- Dotenv
				"jsonlint", -- JSON
				"mbake", -- Makefile
				"yamllint", -- YAML
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
