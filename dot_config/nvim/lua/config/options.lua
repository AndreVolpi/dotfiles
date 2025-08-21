local opt = vim.opt

-- UI
opt.clipboard = "unnamedplus"
opt.showcmd = true
opt.showmode = true
opt.number = true
opt.relativenumber = true
opt.colorcolumn = "120"

-- Files
opt.autoread = true
opt.hidden = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indent
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.expandtab = true
opt.linebreak = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Performance
opt.cmdheight = 2
opt.updatetime = 300

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 15
opt.sidescroll = 1

-- Mouse
opt.mouse = "a"

-- Local rc
opt.exrc = true
