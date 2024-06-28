{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];

    extraLuaConfig = /* lua */ ''
      vim.g.foldexpr = 'nvim_treesitter#foldexpr()',
      require('nvim-treesitter.configs').setup({ highlight = { enable = true } })
    '';
  };
}
