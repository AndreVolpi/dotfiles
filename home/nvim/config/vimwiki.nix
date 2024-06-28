{ pkgs, ... }:
let
  fromGitHub = import ../functions/fromGitHub.nix;
in
{
  programs.neovim = {
    plugins = [
      pkgs.vimPlugins.vimwiki
      (fromGitHub {
        inherit pkgs;
        owner = "ElPiloto";
        repo = "telescope-vimwiki.nvim";
        rev = "13a83b6107da17af9eb8a1d8e0fe49e1004dfeb4";
        sha256 = "46N1vMSu1UuzPFFe6Yt39s3xlKPOTErhPJbfaBQgq7g=";
      })
    ];

    extraLuaConfig = /* lua */ ''
      -- VimWiki
      vim.g.vimwiki_list = {{ path = '~/notes/', synax = 'markdown', ext = '.md' }}

      -- Telescope extensions
      require('telescope').load_extension('vimwiki')
    '';
  };
}
