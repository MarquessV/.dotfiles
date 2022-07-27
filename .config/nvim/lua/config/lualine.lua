local navic = require("nvim-navic")

require('lualine').setup({
	options = {
		theme = 'auto',
		globalstatus = true
	},
	sections = {
		lualine_b = { 'branch', 'diff', {'diagnostics', sources = {'nvim_lsp'}} },
		lualine_c = { 'filename', {navic.get_location, cond = navic.is_available} },
		lualine_x = { 'fileformat', 'filetype' }
	}
})
