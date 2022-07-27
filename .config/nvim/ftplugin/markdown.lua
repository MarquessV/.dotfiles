local nmaps = {
	["<leader>"] = {
		name = "Markdown",
		["p"] = { "<cmd>Glow<CR>", "Preview" }
	}
}

local nopts = {
	mode = 'n',
	noremap = true,
	silent = true,
	buffer = vim.fn.bufnr()
}

require("which-key").register(nmaps, nopts)
