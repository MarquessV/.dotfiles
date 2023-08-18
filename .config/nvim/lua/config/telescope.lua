local actions = require("telescope.actions")

local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_config = {
			height = 0.80,
			width = 0.80,
			prompt_position = "top",
			preview_cutoff = 120,
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "%.out", "vendor", "^%.git/", "^%.mypy-cache/" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { truncate = 1 },
		winblend = 0,
		border = true,
		borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
		color_devicons = true,
		dynamic_preview_title = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		prefilter_sorter = require("telescope.sorters").prefilter,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = trouble.open_with_trouble,
			},
			n = {
				["<C-q>"] = trouble.open_with_trouble,
			},
		},
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<c-w>"] = require("telescope.actions").delete_buffer,
				},
			},
		},
		finder = {
			cwd_to_path = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
		},
	},
})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("harpoon")
