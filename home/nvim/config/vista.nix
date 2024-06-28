{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vista-vim
    ];

    extraLuaConfig = /* lua */ ''
      vim.g.vista_default_executive = 'nvim_lsp'
      vim.api.nvim_set_keymap('n', '<leader>v', '<cmd>Vista!!<CR>', {silent = true})
    '';
  };
}
