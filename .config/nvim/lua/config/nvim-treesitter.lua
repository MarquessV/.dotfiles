require("nvim-treesitter.configs").setup {
	ensure_installed = "all",
	highlight = {
		enable = true
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
		    [']m'] = '@function.outer',
		    [']]'] = '@class.outer'
		},
		goto_next_end = {
		    [']m'] = '@function.outer',
		    [']['] = '@class.outer'
		},
		goto_previous_start = {
		    ['[m'] = '@function.outer',
		    ['[['] = '@class.outer'
		},
		goto_previous_end = {
		    ['[m'] = '@function.outer',
		    ['[]'] = '@class.outer'
		}
	}
}
