{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      airline
      vim-airline-themes
    ];

    extraLuaConfig = /* lua */ ''
      vim.g.airline_powerline_fonts = true
      vim.g.airline_theme = 'onedark'
    '';
  };
}
