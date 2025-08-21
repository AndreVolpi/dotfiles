return {
  "drzel/vim-split-line",
  init = function()
    vim.keymap.set("n", "S", "<cmd>SplitLine<CR>")
  end
}
