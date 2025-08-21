vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { silent = true })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true })
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { silent = true })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true })
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { silent = true })
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>")

lsp_on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

lsp_capabilities = function()
  return require("cmp_nvim_lsp").default_capabilities()
end

lsp_setup = {
  capabilities = lsp_capabilities(),
  on_attach = lsp_on_attach,
}
