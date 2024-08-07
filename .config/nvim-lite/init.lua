-- Must set leader before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.loader.enable()

-- Bootstrap lazy.nvim
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

-- Options

-- Persist undo history across sessions
vim.o.undofile = true

-- Disable backups
vim.o.backup = false
vim.o.writebackup = false

-- Load filetype and plugins
vim.cmd("filetype plugin indent on")

-- Visual

-- Persist visual indentation on wrapped lines
vim.o.breakindent = true
vim.o.linebreak = true

-- Highlith cursor
vim.o.cursorline = true

-- Show line numbers
vim.o.number = true

-- Better split behavior
vim.o.splitbelow = true
vim.o.splitright = true

-- Disable native UI elements we don't need
vim.o.ruler = false
vim.o.showmode = false

vim.o.wrap = true
-- Always show signcolumn
vim.o.signcolumn = "yes"
-- No ~ after the end of the buffer
vim.o.fillchars = "eob: "

-- Highlight search results, ignore case unless a capital appears
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.infercase = true
vim.o.smartcase = true

-- Attempt to correctly indent new lines
vim.o.smartindent = true

-- Allow cursor to position itself anywhere during visual mode.
vim.o.virtualedit = "block"

-- Reduce nvim messages
vim.opt.shortmess:append("WcC")

-- Keep text on the same line when resizing windows
vim.o.splitkeep = "screen"

-- Share OS clipboard
vim.o.clipboard = "unnamedplus"

-- Settings for completion options
vim.o.completeopt = "menuone,noinsert,noselect"

-- Allow buffers to be hidden
vim.o.hidden = true

-- Allow .nvim.lua files to be loaded
vim.o.exrc = true

-- Number of lines to keep above and below cursor
vim.o.scrolloff = 12

-- Whitespace
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.foldenable = false

if vim.fn.exists("syntax_on") ~= 1 then
	vim.cmd([[syntax enable]])
end

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Better characters for drawing border between splits
vim.opt.fillchars:append("vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣")

-- Use <Tab> to cycle through buffers in tab
vim.keymap.set("n", "<Tab>", "<C-W>w")
vim.keymap.set("n", "<S-Tab>", "<C-W>W")
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>")

-- disable all providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Global configuration values and flags
Config = {
	theme = "rose-pine",
	wrap_func = function(func, params)
		return function()
			func(params)
		end
	end,
}

vim.filetype.add({
	extension = {
		vert = "glsl",
		frag = "glsl",
	},
})

require("config.plugins")
