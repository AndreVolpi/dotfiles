local map = vim.keymap.set

map("n", "Y", "y$")
map("n", "<A-,>", "<cmd>BufferPrevious<CR>", { silent = true })
map("n", "<A-.>", "<cmd>BufferNext<CR>", { silent = true })
map("n", "<A-<>", "<cmd>BufferMovePrevious<CR>", { silent = true })
map("n", "<A->>", "<cmd>BufferMoveNext<CR>", { silent = true })
map("n", "<A-0>", "<cmd>BufferLast<CR>", { silent = true })
map("n", "<A-c>", "<cmd>BufferClose<CR>", { silent = true })

-- Split-line
map("n", "S", "<cmd>SplitLine<CR>")
