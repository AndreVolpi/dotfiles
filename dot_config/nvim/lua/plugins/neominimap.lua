return {
  "Isrothy/neominimap.nvim",
  version = "v3.*.*",
  lazy = false,
  init = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.breakindent = true
    vim.opt.showbreak = "↪ "
    vim.g.neominimap = {
      auto_enable = true,
      layout = "split",
      split = {
        direction = "right",
        close_if_last_window = true,
        fix_width = true,
      },
    }
  end,
}
