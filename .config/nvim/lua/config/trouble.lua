require("trouble").setup({})

local nmaps = {
	["<leader>"] = {
		x = {
			x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble" },
			w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Worksace Diagnostics" },
			d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
		},
	},
}

require("which-key").register(nmaps, { mode = "n", noremap = true, silent = true })
