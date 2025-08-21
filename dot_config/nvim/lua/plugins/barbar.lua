return {
  "romgrk/barbar.nvim",
  config = function()
    require("barbar").setup({
      autoHide = false,
      clickable = true,
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
      icons = { filetype = { customColors = false, enable = true } },
      sidebarFiletypes = { chadtree = true, nerdtree = true, vista = true },
    })
  end,
}
