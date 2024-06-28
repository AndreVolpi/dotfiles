{ pkgs, lib, ... }: {
  # Import all your configuration modules here
  imports = [
    ./config
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      onedark-nvim
    ];

    extraLuaConfig = /* lua */ ''
      onedark = require('onedark')
      onedark.setup({
        style = 'darker'
      })
      onedark.load()

      vim.opt.clipboard = 'unnamedplus'
      vim.opt.showcmd = true -- Show incomplete cmds down the bottom
      vim.opt.showmode = true -- Show current mode down the bottom
      vim.opt.number = true -- Show line numbers
      vim.opt.relativenumber = true -- Show line numbers
      vim.opt.autoread = true -- Reload files changed outside of Vim

      vim.opt.hidden = true -- Hide buffers when not displayed
      vim.opt.cmdheight = 2 -- Larger command space
      vim.opt.updatetime = 300 -- Shorter update time
      vim.opt.colorcolumn = '120' -- Marks the line length limit

      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.writebackup = false

      vim.opt.scrolloff = 8 -- Start scrolling when were 8 lines away from margins
      vim.opt.sidescrolloff = 15
      vim.opt.sidescroll = 1

      vim.opt.mouse = 'a'

      vim.opt.incsearch = true -- Find the next match as we type the search
      vim.opt.hlsearch = true -- Highlight searches by default
      vim.opt.ignorecase = true -- Ignore case when searching...
      vim.opt.smartcase = true -- ...unless we type a capital

      vim.opt.autoindent = true
      vim.opt.smartindent = true
      vim.opt.smarttab = true
      vim.opt.expandtab = true

      vim.opt.linebreak = true -- Wrap lines at convenient points

      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
    '';

  };
}
