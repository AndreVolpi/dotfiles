{
  programs.neovim = {
    extraLuaConfig = /* lua */ ''
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'c', 'h', 'cpp', 'hpp' },
        command = 'setl cindent ts=4 sts=4 sw=4 noet nolist',
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'asm' },
        command = 'setl ts=8 sts=8 sw=8 noet',
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'go' },
        command = 'setl ts=4 sts=4 sw=4 noet commentstring=//%s',
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'make', 'automake' },
        command = 'setl ts=4 sts=4 sw=4 noet',
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'erlang', 'javascript', 'lua', 'python' },
        command = 'setl ts=4 sts=4 sw=4',
      })
      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function() vim.highlight.on_yank() end
      })
    '';
  };
}
