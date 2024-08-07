{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
    ];

    extraLuaConfig = /* lua */ ''
      require('telescope').setup({
        defaults = {
          display_path = 'smart',
          find_command = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" },
        },
        extensions = { fzf = { case_mode = 'smart_case', fuzzy = true } },
        pickers = {
          fd = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" },
          },
        },
      })

      vim.keymap.set('n', '<leader>fd', '<cmd>Telescope fd<cr>')
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      vim.keymap.set('n', '<leader>fr', '<cmd>Telescope resume<cr>')
    '';
  };
}
