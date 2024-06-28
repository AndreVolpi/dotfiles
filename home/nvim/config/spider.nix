{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-spider
    ];

    extraLuaConfig = /* lua */ ''
      require('spider').setup({})

      vim.keymap.set({ 'n', 'o', 'x' }, 'w', '<cmd>lua require("spider").motion("w")<CR>', { desc = 'Spider-w' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', '<cmd>lua require("spider").motion("e")<CR>', { desc = 'Spider-e' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', '<cmd>lua require("spider").motion("b")<CR>', { desc = 'Spider-b' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'ge', '<cmd>lua require("spider").motion("ge")<CR>', { desc = 'Spider-g' })
    '';
  };
}
