local wk = require("which-key")

local function toggle_lsp_lines()
	local current = vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = not current, virtual_text = current })
end

wk.setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = { enabled = true, suggestions = 36 },
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	key_labels = { ["<space>"] = "SPC", ["<cr>"] = "RET", ["<Tab>"] = "TAB" },
	icons = { breadcrumb = "»", separator = "➜", group = "+" },
	window = {
		border = "single",
		position = "bottom",
		margin = { 1, 0, 1, 0 },
		padding = { 0, 2, 0, 2 },
	},
	layout = {
		height = { min = 4, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 3,
		align = "left",
	},
	ignore_missing = false,
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
	show_help = true,
	triggers = "auto",
	triggers_blacklist = { i = { "j", "k" }, v = { "j", "k" } },
})

local nmaps = {
	["<C-a>"] = { "ggVG", "Select All" },
	["<C-p>"] = { "<cmd>Telescope find_files hidden=true<CR>", "Find files" },
	["<Tab>"] = { "<cmd>bn<CR>", "Next Buffer" },
	["<S-Tab>"] = { "<cmd>bp<CR>", "Prev Buffer" },
	["<C-s>"] = { "<cmd>w<CR>", "Write Buffer" },
	["-"] = { "<cmd>Telescope file_browser path=%:p:h hidden=true<CR>", "File Browser" },
	["<Space>"] = { "za", "Toggle Fold" },
	["<leader>"] = {
		c = { name = "Comment", c = { "<cmd>CommentToggle<CR>", "Comment Line" } },
		e = { v = { "<cmd>vsp ~/.config/nvim/init.lua<CR>", "Edit Config" } },
		f = {
			name = "Find",
			f = { "<cmd>Telescope find_files<CR>", "Files" },
			g = { "<cmd>Telescope live_grep<CR>", "Grep" },
			o = { "<cmd>Telescope oldfiles<CR>", "Old Files" },
			w = { "<cmd>Telescope grep_string<CR>", "Find Word" },
		},
		s = {
			v = {
				"<cmd>source ~/.config/nvim/init.lua | Lazy sync<CR>",
				"Sync Config",
			},
			t = {
				'<cmd>exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>',
				"Toggle dark mode",
			},
		},
		t = {
			name = "Tests",
			l = {
				'<cmd>lua require("neotest").run.run()<CR>',
				"Test Function",
			},
			f = {
				'<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
				"Test File",
			},
			a = {
				'<cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>',
				"Test All",
			},
			s = {
				'<cmd>lua require("neotest").summary.toggle()<CR>',
				"Toggle Test Summary",
			},
			o = {
				'<cmd>lua require("neotest").output_panel.toggle()<CR>',
				"Toggle Test Output Panel",
			},
			x = {
				'<cmd>lua require("neotest").output.open({enter = true, auto_close = true})<CR>',
				"Toggle Test Output Window",
			},
		},
		x = {
			t = {
				function()
					toggle_lsp_lines()
				end,
				"Toggle lsp_lines",
			},
		},
		d = {
			name = "Debugging",
			c = { ":lua require('dap').continue()<cr>", "Continue" },
			s = { ":lua require('dap').step_over()<cr>", "Step Over" },
			i = { ":lua require('dap').step_into()<cr>", "Step Into" },
			o = { ":lua require('dap').step_out()<cr>", "Step Out" },
			b = { ":lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			B = {
				":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
				"Set Breakpoint w/ Condition",
			},
			r = { ":lua require('dap').repl.open()<cr>", "Open REPL" },
			u = { ":lua require('dapui').toggle()<cr>", "Toggle DAP UI" },
			q = { ":lua require('dap').terminate()<cr>", "Quit DAP session" },
			t = {
				name = "Tests",
				l = {
					'<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
					"Test Function",
				},
				f = {
					'<cmd>lua require("neotest").run.run(vim.fn.expand("%"), {strategy = "dap"})<CR>',
					"Test File",
				},
				a = {
					'<cmd>lua require("neotest").run.run(vim.fn.getcwd(), {strategy = "dap"})<CR>',
					"Test All",
				},
			},
		},
		o = {
			name = "Overseer",
			t = { "<cmd>OverseerToggle<CR>", "Toggle Overseer panel" },
			r = { "<cmd>OverseerRun<CR>", "Run task" },
			s = { "<cmd>OverseerRunCmd<CR>", "Run shell command" },
			p = { "<cmd>OverseerQuickAction restart<CR>", "Re-run previous command" },
		},
		["<Space>"] = { ":nohlsearch<CR>", "Clear Highlights" },
		["<Tab>"] = { "<cmd>Telescope buffers<CR>", "Show Buffers" },
	},
	["]q"] = {
		function()
			require("trouble").next({ skip_groups = true, jump = true })
		end,
		"Next Trouble entry",
	},
	["]Q"] = { -- jump to the last item, skipping the groups
		function()
			require("trouble").last({ skip_groups = true, jump = true })
		end,
		"Next Trouble entry",
	},
	["[q"] = {
		function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end,
		"Previous Trouble entry",
	},
	["[Q"] = { -- jump to the last item, skipping the groups
		function()
			require("trouble").first({ skip_groups = true, jump = true })
		end,
		"First Trouble entry",
	},
}

local vmaps = {
	["<c-c>"] = { '"+y', "Copy to Clipboard" },
	["<leader>"] = { c = { "Comment Selection" } },
}

wk.register(nmaps, { mode = "n", noremap = true, silent = true })
wk.register(vmaps, { mode = "v", noremap = true, silent = true })
