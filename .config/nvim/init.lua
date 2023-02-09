local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

Config = { theme = "everforest", lsp = { highlight = true } }

require("config.lazy")

-- Mappings
vim.g.mapleader = ","

-- LSP
vim.o.hidden = true
vim.o.updatetime = 300
vim.o.backup = false
vim.o.writebackup = false

-- Shorter timeout waiting for completion of a mapped sequence
vim.o.timeoutlen = 500

-- Visual
vim.wo.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.cmdheight = 1
vim.o.termguicolors = true
vim.cmd.colorscheme(Config.theme)

-- Search behavior
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true

-- Split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- Folds
vim.o.foldlevel = 20
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.clipboard = "unnamed"

-- Enable mouse
vim.o.mouse = "a"

-- Whitespace
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Misc
vim.o.title = true
vim.o.scrolloff = 8
vim.o.exrc = true
