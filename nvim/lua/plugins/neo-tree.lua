return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("neo-tree").setup({
      auto_clean_after_session_restore = true,
      close_if_last_window = true
    })

    vim.keymap.set('n', '<leader>pf', '<cmd>Neotree toggle reveal focus float<CR>', { silent = true; })
    vim.keymap.set('n', '<leader>pb', '<cmd>Neotree toggle reveal focus float buffers<CR>', { silent = true; })
    vim.keymap.set('n', '<leader>pg', '<cmd>Neotree toggle reveal focus float git_status<CR>', { silent = true; })
  end
}
