vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })

lsp_on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, ops)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	vim.keymap.set("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

lsp_capabilities = function()
	return require("cmp_nvim_lsp").default_capabilities()
end

lsp_setup = {
	capabilities = lsp_capabilities(),
	on_attach = lsp_on_attach,
}
