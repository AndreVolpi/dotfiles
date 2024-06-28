{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      barbar-nvim
      nvim-web-devicons
    ];

    extraLuaConfig = /* lua */ ''
      require('barbar').setup({
          autoHide = false,
          clickable = true,
          gitsigns = {
            added = { enabled = true, icon = '+' },
            changed = { enabled = true, icon = '~' },
            deleted = { enabled = true, icon = '-' },
          },
          icons = { filetype = { customColors = false, enable = true } },
          sidebarFiletypes = { chadtree = true, nerdtree = true, vista = true },
      })
    '';
  };
}
