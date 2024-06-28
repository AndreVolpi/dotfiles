{ pkgs, inputs, ... }:
let
  # ePlugins are the plugins that are not available in nixpkgs/nixvim/NixNeovimPlugins
  fromGitHub = import ../functions/fromGitHub.nix;
  ePlugins = [
    (fromGitHub {
      inherit pkgs;
      owner = "drzel";
      repo = "vim-split-line";
      rev = "9e26b7ce134a4a9a47fc72b9838de70907d4957a";
      sha256 = "jRMnxPBqMyaqMay7zgAKfoFrbKStBsq3HLdnZCh8iG0=";
    })
    (fromGitHub {
      inherit pkgs;
      owner = "yuki-yano";
      repo = "zero.nvim";
      rev = "ec0b1adcb3a34fad96c7a04bf0130db716f66e8c";
      sha256 = "eD7+iJ41uPJLKwL71/DhNCbfy2OjimNOpy7Yc66GjAA=";
    })
  ];

  # aPlugins are available in NixNeovimPlugins
  aPlugins = with pkgs.vimExtraPlugins; [
    hlchunk-nvim
    keymap-amend-nvim
    nvim-origami
  ];

  # nPlugins are normally available in nixpkgs
  nPlugins = with pkgs.vimPlugins; [
    auto-session
    clever-f-vim
    context-vim
    hmts-nvim
    rainbow
    nvim-scrollview
    text-case-nvim
    train-nvim
    twilight-nvim
    vim-expand-region
    vim-numbertoggle
    vim-signify
    vim-visual-increment
  ];
in
{
  programs.neovim = {
    plugins = nPlugins ++ ePlugins ++ aPlugins;

    extraLuaConfig = /* lua */ ''
      vim.o.foldenable = false

      -- Auto-session
      require('auto-session').setup({
        auto_session_root_dir = '~/nvim_sessions/',
        auto_restore_enabled = true,
        auto_session_use_git_branch = true
      })
      require('telescope').load_extension('session-lens')

      -- Clever-f
      vim.g.clever_f_smart_case = true

      -- HlChunk
      require('hlchunk').setup({
        blank = {
          enable = false,
        }
      })

      -- Nvim-Origami
      vim.o.startofline = true
      require('origami').setup ({
        keepFoldsAcrossSessions = true,
        pauseFoldsOnSearch = true,
        setupFoldKeymaps = true,
      })

      -- Rainbow
      vim.g.rainbow_active = '1'

      -- Scrollview
      vim.g.scrollview_excluded_filetypes = {'nerdtree', 'chadtree', 'vista'}
      vim.g.scrollview_current_only = true
      vim.g.scrollview_signs_on_startup = {'all'}

      -- Split-Line
      vim.keymap.set('n', 'S', '<cmd>SplitLine<CR>')

      -- Text-Case
      require('textcase').setup({})
      require('telescope').load_extension('textcase')
      vim.keymap.set({ 'n', 'v' }, 'ga.', '<cmd>TextCaseOpenTelescope<CR>')

      -- Zero
      require('zero').setup()
    '';
  };
}
