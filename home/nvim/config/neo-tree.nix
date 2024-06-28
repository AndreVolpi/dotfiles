{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      neo-tree-nvim
    ];

    extraLuaConfig = /* lua */ ''
      require('neo-tree').setup({
        auto_clean_after_session_restore = true,
        close_if_last_window = true
      })

      vim.keymap.set('n', '<leader>pf', '<cmd>Neotree toggle reveal focus float<CR>', { silent = true; })
      vim.keymap.set('n', '<leader>pb', '<cmd>Neotree toggle reveal focus float buffers<CR>', { silent = true; })
      vim.keymap.set('n', '<leader>pg', '<cmd>Neotree toggle reveal focus float git_status<CR>', { silent = true; })
    '';
  };
}
