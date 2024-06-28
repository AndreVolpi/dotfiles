{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-startify
    ];

    extraLuaConfig = /* lua */ ''
      vim.g.startify_change_cmd = 'cd'
      vim.g.startify_change_to_vcs_root = true
      vim.g.startify_session_dir = '~/nvim_sessions'
      vim.g.startify_session_persistence = true
      vim.g.startify_session_sort = true
    '';
  };
}
