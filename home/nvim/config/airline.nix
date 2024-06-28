{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      airline
    ];

    extraLuaConfig = /* lua */ ''
      vim.g.airline_powerline_fonts = true
    '';
  };
}
