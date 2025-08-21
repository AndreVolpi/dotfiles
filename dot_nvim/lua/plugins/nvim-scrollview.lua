return {
  "dstein64/nvim-scrollview",
  config = function()
    vim.g.scrollview_excluded_filetypes = { "nerdtree", "chadtree", "vista" }
    vim.g.scrollview_current_only = true
    vim.g.scrollview_signs_on_startup = { "all" }
  end
}
