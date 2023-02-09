local nmaps = {
	["<leader>k"] = {
		name = "Go",
		["i"] = { "<cmd>GoImpl ", "Implement interface" },
		["e"] = { "<cmd>GoIfErr<CR>", "Generate if err..." },
	},
}

local nopts = {
	mode = "n",
	noremap = true,
	silent = true,
	buffer = vim.fn.bufnr(),
}

require("which-key").register(nmaps, nopts)
