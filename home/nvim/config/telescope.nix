{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
    ];

    extraLuaConfig = /* lua */ ''
      require('telescope').setup({
        defaults = { display_path = 'smart' },
        extensions = { fzf = { case_mode = 'smart_case', fuzzy = true } },
      })

      vim.keymap.set('n', '<C-p>', '<cmd>Telescope fd<cr>')
      vim.keymap.set('n', '<C-f>f', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<C-f>b', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
      vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>')
    '';
  };
}
