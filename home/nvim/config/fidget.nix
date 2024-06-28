{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      fidget-nvim
    ];

    extraLuaConfig = /* lua */ ''
      require("fidget").setup {}
    '';
  };
}
