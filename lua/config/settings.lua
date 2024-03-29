vim.loader.enable()

-- Sets the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true -- Current line is real line number if true rather than 0
vim.wo.relativenumber = true -- Line numbers are relative to current line

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- TODO: Order these
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undolevels = 30000
vim.opt.scrolloff = 15
vim.opt.updatetime = 50
vim.opt.autowrite = false
vim.opt.cursorline = false
vim.opt.confirm = true
vim.opt.spelllang = "en"
vim.opt.fillchars:append({ eob = " " })

-- Sluth auto detects
--vim.opt.softtabstop = 4
--vim.opt.shiftwidth = 4
--vim.opt.expandtab = true
--vim.opt.tabstop = 4

-- Sync with system clipboard
vim.opt.clipboard = "unnamedplus"
