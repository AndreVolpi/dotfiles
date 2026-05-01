return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			lua = { "selene" },
			python = { "flake8" },
			go = { "golangci-lint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			terraform = { "tflint" },
			json = { "jsonlint" },
			yaml = { "yamllint" },
			dockerfile = { "hadolint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
