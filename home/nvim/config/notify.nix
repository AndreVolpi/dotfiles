{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-notify
    ];

    extraLuaConfig = /* lua */ ''
      vim.notify = require('notify')
      require('notify').setup({ ['level'] = vim.log.levels.INFO })
    '';
  };
}
