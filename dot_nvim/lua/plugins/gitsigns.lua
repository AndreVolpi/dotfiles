return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      on_attach = function(bufnr)
        set_buf_keymap = vim.api.nvim_buf_set_keymap
        opts = { noremap = true, silent = true }
        set_buf_keymap(bufnr, 'n', '[g', '&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', { noremap = true, silent = true, expr = true })
        set_buf_keymap(bufnr, 'n', ']g', '&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', { noremap = true, silent = true, expr = true })

        set_buf_keymap(bufnr, 'n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>', opts)
        set_buf_keymap(bufnr, 'v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', opts)
        set_buf_keymap(bufnr, 'v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>', opts)
        set_buf_keymap(bufnr, 'n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', opts)

        set_buf_keymap(bufnr, 'o', 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>', opts)
        set_buf_keymap(bufnr, 'x', 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>', opts)
      end,
    })
  end
}
