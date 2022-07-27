local install_path = vim.fn.stdpath("data") ..
                         "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("Downloading Packer ...")
    vim.fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    vim.api.nvim_command("packadd packer.nvim")
    require("config.packer")
    require("packer").sync()
end

-- require("impatient")
require("config.packer")

Config = {theme = "leaf", lsp = {hightlight = true}}

-- Mappings
vim.g.mapleader = ','

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
vim.o.cmdheight = 0
vim.o.termguicolors = true
vim.cmd("colorscheme " .. Config.theme)

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
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.clipboard = 'unnamed'

-- Enable mouse
vim.o.mouse = "a"

-- Whitespace
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Misc
vim.o.title = true
vim.o.scrolloff = 8
