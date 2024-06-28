{ pkgs, ... }: {
  programs.neovim = {
    extraLuaConfig = /* lua */ ''
      vim.keymap.set('n', 'Y', 'y$')
      vim.keymap.set('n', '<A-,>', '<cmd>BufferPrevious<CR>', { silent = true; })
      vim.keymap.set('n', '<A-.>', '<cmd>BufferNext<CR>', { silent = true; })
      vim.keymap.set('n', '<A-<>', '<cmd>BufferMovePrevious<CR>', { silent = true; })
      vim.keymap.set('n', '<A->>', '<cmd>BufferMoveNext<CR>', { silent = true; })
      vim.keymap.set('n', '<A-0>', '<cmd>BufferLast<CR>', { silent = true; })
      vim.keymap.set('n', '<A-c>', '<cmd>BufferClose<CR>', { silent = true; })
    '';
  };
}
