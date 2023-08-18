local winbar_settings = {
	lualine_a = {
		{ "filetype", icon_only = true, colored = false },
		{
			"filename",
			path = 1,
			shorting_target = 250,
			symbols = {
				modified = " ●",
				readonly = " ",
			},
		},
	},
	lualine_b = {
		"diff",
		{ "diagnostics" },
	},
	lualine_c = {
		"navic",
	},
}
require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { { "buffers", show_filename_only = false } },
		lualine_x = { "overseer" },
		lualine_y = { "progress", "searchcount" },
		lualine_z = { "location" },
	},
	winbar = vim.tbl_extend("keep", winbar_settings, {
		lualine_y = { "progress", "searchcount" },
		lualine_z = { "location" },
	}),
	inactive_winbar = winbar_settings,
})
