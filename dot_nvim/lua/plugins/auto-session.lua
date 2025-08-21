return {
  "rmagatti/auto-session",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("auto-session").setup({
      auto_restore = true,
      git_use_branch_name = true,
      root_dir = "~/nvim_sessions/",
    })
    require("telescope").load_extension("session-lens")
  end
}
