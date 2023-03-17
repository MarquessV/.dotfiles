local navic = require("nvim-navic")

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	sections = {
		lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp" } } },
		lualine_c = {
			{
				"filename",
				path = 1,
				symobls = {
					modified = " ●",
				},
			},
			{ navic.get_location, cond = navic.is_available },
		},
		lualine_x = { "fileformat", "filetype" },
	},
})
