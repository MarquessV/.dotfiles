require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_formatter_opts = { relative_time = true },
	on_attach = function(bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true }
		local maps = {
			["<leader>g"] = {
				name = "Git",
				j = { "<cmd>lua require ('gitsigns').next_hunk()<cr>", "Next Hunk" },
				k = { "<cmd>lua require ('gitsigns').prev_hunk()<cr>", "Prev Hunk" },
				l = { "<cmd>lua require ('gitsigns').blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require ('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
				r = { "<cmd>lua require ('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
				R = { "<cmd>lua require ('gitsigns').reset_buffer()<cr>", "Reset Buffer" },
				s = { "<cmd>lua require ('gitsigns').stage_hunk()<cr>", "Stage Hunk" },
				u = {
					"<cmd>lua require ('gitsigns').undo_stage_hunk()<cr>",
					"Undo Stage Hunk",
				},
				g = { "<cmd>Neogit<cr>", "Git" },
				b = { "<cmd>Telescope git_branches<CR>", "Branches" },
			},
			["<leader>f"] = {
				p = { "<cmd>Telescope git_files<CR>", "Git Files" },
			},
		}
		require("which-key").register(maps, opts)
	end,
})
