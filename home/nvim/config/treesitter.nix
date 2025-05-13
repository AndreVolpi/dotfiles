{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];

    extraLuaConfig = /* lua */ ''
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        indent = { enable = true },
        -- this ensures foldexpr works
        fold = { enable = true } -- even if this isn't required, it's good to keep for clarity
      })
    '';
  };
}
