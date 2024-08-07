return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		"folke/trouble.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		local open_with_trouble = require("trouble.sources.telescope").open

		require("telescope").setup({
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					height = 0.9,
					width = 0.95,
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-q>"] = open_with_trouble,
					},
					n = {
						["<C-q>"] = open_with_trouble,
					},
				},
			},
			file_ignore_patterns = { "%.out", "vendor", "^%.git/", "^%.mypy-cache/" },
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set({ "n", "i" }, "<C-p>", builtin.find_files)
		vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "[G]rep files" })
		vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Search [b]uffers" })
	end,
}
