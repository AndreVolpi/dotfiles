return {
    "mason-org/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {},
    build = ":MasonUpdate",
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup {
          ensure_installed = {
            "gopls",        -- Go
            "ts_ls",     -- Node/TS
            "ruby_lsp",      -- Ruby
            "pyright",      -- Python
          },
          automatic_installation = true,
        }
        
        require("mason-tool-installer").setup {
          ensure_installed = {
            -- Formatters
            "prettier",       -- JS/TS
            "stylua",         -- Lua
            "black",          -- Python
            "rubocop",        -- Ruby
            "gofumpt",        -- Go
        
            -- Linters
            "eslint_d",       -- JS/TS
            "flake8",         -- Python
            "golangci-lint",  -- Go
        
            -- Extra utils
            "yamllint",
            "jsonlint",
          },
          auto_update = true,
          run_on_start = true,
        }
    end,
}
