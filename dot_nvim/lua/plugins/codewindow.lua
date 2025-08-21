return {
  "gorbit99/codewindow.nvim",
  config = function()
    require("codewindow").setup()
  end,
  init = function()
    require("codewindow").apply_default_keybinds()
  end
}
