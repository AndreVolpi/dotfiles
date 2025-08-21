-- init.lua
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.opt.termguicolors = true

-- Lazynvim plugin manager setup
require("config.lazy")  -- plugin list & configs

-- Load core configs
require("config.autocmds")
require("config.keymaps")
require("config.lsp")
require("config.options")
