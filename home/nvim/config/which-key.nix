{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      which-key-nvim
    ];

    extraLuaConfig = /* lua */ ''
      require('which-key').setup({})
    '';
  };
}
