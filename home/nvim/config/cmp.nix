{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      cmp-buffer
      cmp-fuzzy-path
      cmp-rg
      cmp-vimwiki-tags
      cmp-treesitter
      cmp-cmdline
      cmp-cmdline-history
    ];

    extraLuaConfig = /* lua */ ''
        cmp = require('cmp')
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-e>'] = cmp.mapping.close(),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
          }),
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim-lsp-signature-help' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'fuzzy-path' },
            { name = 'rg' },
            { name = 'vimwiki-tags' },
            { name = 'treesitter' },
            { name = 'cmdline' },
            { name = 'cmdline-history' },
          }),
      })
    '';
  };
}
