return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "lua", "vim", "javascript", "typescript", "go" },
      fold = { enable = true } -- even if this isn't required, it's good to keep for clarity
    })
  end,
}
