local plugins = {
	-- LSP
	require("config.lsp.lsp"),
	-- Testing
	require("config.test"),
	-- Debugging
	require("config.dap"),
	-- Dependency Management
	require("config.mason"),
	-- Miscenllaneous Keymaps
	require("config.keymaps"),
	-- Statusline + winbar
	require("config.statusline"),
	-- Fuzzy searching
	require("config.fuzzy"),
	-- Python specific plugins
	require("config.python"),
	-- Rust specific plugins
	require("config.rust"),

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		enable = true,
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				transparent_background_level = 1,
				highlight = {
					enable = true,
					additinonal_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-CR>",
						node_incremental = "<CR>",
						node_decremental = "<BS>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahed = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true of false
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["mf"] = "@function.outer",
							["mc"] = { query = "@class.outer", desc = "Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
							["ml"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["mv"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["mz"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["mF"] = "@function.outer",
							["mC"] = "@class.outer",
						},
						goto_previous_start = {
							["Mf"] = "@function.outer",
							["Mc"] = "@class.outer",
						},
						goto_previous_end = {
							["MF"] = "@function.outer",
							["MC"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["mi"] = "@conditional.outer",
						},
						goto_previous = {
							["mi"] = "@conditional.outer",
						},
					},
				},
			})
		end,
	},

	-- File browser
	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup()
			vim.keymap.set("n", "_", function()
				require("mini.files").open()
			end, { silent = true })
			vim.keymap.set("n", "-", function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0))
			end, { silent = true })
		end,
	},

	-- Command runner
	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>rt", "<cmd>OverseerRun<cr>", desc = "[R]un task." },
			{ "<leader>rr", "<cmd>OverseerRestartLast<cr>", desc = "[R]estart last task." },
			{ "<leader>rm", "<cmd>Make<cr>", desc = "[M]ake." },
			{ "<leader>ro", "<cmd>OverseerToggle<cr>", desc = "[O]pen overseer window." },
		},
		config = function()
			local overseer = require("overseer")
			overseer.setup()
			vim.api.nvim_create_user_command("OverseerRestartLast", function()
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify("No tasks found", vim.log.levels.WARN)
				else
					overseer.run_action(tasks[1], "restart")
				end
			end, {})

			vim.api.nvim_create_user_command("Make", function(params)
				-- Insert args at the '$*' in the makeprg
				local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
				if num_subs == 0 then
					cmd = cmd .. " " .. params.args
				end
				local task = overseer.new_task({
					cmd = vim.fn.expandcmd(cmd),
					components = {
						{
							"on_output_quickfix",
							tail = false,
							open_on_exit = "failure",
							open_height = 8,
							close = true,
						},
						"default",
					},
				})
				task:start()
			end, {
				desc = "Run your makeprg as an Overseer task",
				nargs = "*",
				bang = true,
			})
			overseer.add_template_hook({
				module = "^just$",
			}, function(task_defn, util)
				util.add_component(task_defn, { "on_output_quickfix", open = true, close = true, "default" })
			end)
			overseer.add_template_hook({
				module = "^cargo$",
			}, function(task_defn, util)
				util.add_component(task_defn, { "on_output_quickfix", open = true, close = true })
			end)
		end,
		lazy = false,
	},

	-- Comment with gc
	{
		"echasnovski/mini.comment",
		version = "*",
		config = function()
			require("mini.comment").setup()
		end,
	},

	-- Show indentation guides
	{
		"echasnovski/mini.indentscope",
		version = "*",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.exponential({
						easing = "in-out",
						duration = 150,
						unit = "total",
					}),
				},
				options = {
					border = "top",
				},
				symbol = "┃",
			})
		end,
	},

	-- Easily split and join lines with gS
	{
		"echasnovski/mini.splitjoin",
		version = "*",
		config = function()
			require("mini.splitjoin").setup()
		end,
	},

	-- Perform operations that surround text objects with sa, sd, sf[F], sh, sr
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},

	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		opts = {},
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = false,
					auto_trigger = true,
				},
				panel = {
					enabled = false,
				},
				-- keymap = {
				-- 	accept = "<M-l>",
				-- 	accept_word = false,
				-- 	accept_line = false,
				-- 	next = "<M-]>",
				-- 	prev = "<M-[>",
				-- 	dismiss = "<C-]>",
				-- },
			})
		end,
	},

	-- Git info in the sign column, blame in-line
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({ current_line_blame = true })
		end,
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
		keys = {
			{
				"<leader>og",
				function()
					require("neogit").open()
				end,
				desc = "Open neogit",
			},
			{ "<leader>od", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		},
	},

	-- Better quickfix list
	{
		"folke/trouble.nvim",
		-- branch = "dev",
		config = function()
			require("trouble").setup({
				auto_close = true,
			})
			local function ToggleTroubleAuto()
				local ok, trouble = pcall(require, "trouble")
				if ok then
					vim.defer_fn(function()
						vim.cmd("cclose")
						trouble.open("quickfix")
					end, 0)
				end
			end

			vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
				group = vim.api.nvim_create_augroup("TroubleConfig", {}),
				pattern = "quickfix",
				callback = ToggleTroubleAuto,
			})
		end,
	},

	-- Heuristically set indent settings
	{ "tpope/vim-sleuth" },

	-- Navigate kitty and vim splits seamlessly
	{
		"knubie/vim-kitty-navigator",
	},

	{
		"mikesmithgh/kitty-scrollback.nvim",
		enabled = true,
		lazy = true,
		cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
		event = { "User KittyScrollbackLaunch" },
		version = "*", -- latest stable version, may have breaking changes if major version changed
		config = function()
			require("kitty-scrollback").setup()
		end,
	},

	-- Colorschemes
	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
		enabled = Config.theme == "everforest",
		config = function()
			require("everforest").setup({
				background = "hard",
				italics = true,
				on_highlights = function(hl, palette)
					hl.DiagnosticError = { fg = palette.red, bg = palette.none, sp = palette.red }
					hl.DiagnosticWarn = { fg = palette.yellow, bg = palette.none, sp = palette.yellow }
					hl.DiagnosticInfo = { fg = palette.aqua, bg = palette.none, sp = palette.blue }
					hl.DiagnosticHint = { fg = palette.green, bg = palette.none, sp = palette.green }

					-- nvim-cmp menu overrides
					hl.CmpItemAbbrDeprecated = { fg = palette.bg3, bg = palette.red }

					hl.CmpItemKindCopilot = { fg = palette.bg3, bg = palette.green }

					hl.CmpItemKindField = { fg = palette.bg3, bg = palette.purple }
					hl.CmpItemKindProperty = { fg = palette.bg3, bg = palette.purple }
					hl.CmpItemKindEvent = { fg = palette.bg3, bg = palette.purple }

					hl.CmpItemKindText = { fg = palette.bg3, bg = palette.green }
					hl.CmpItemKindEnum = { fg = palette.bg3, bg = palette.green }
					hl.CmpItemKindKeyword = { fg = palette.bg3, bg = palette.green }

					hl.CmpItemKindConstant = { fg = palette.bg3, bg = palette.yellow }
					hl.CmpItemKindConstructor = { fg = palette.bg3, bg = palette.yellow }
					hl.CmpItemKindReference = { fg = palette.bg3, bg = palette.yellow }

					hl.CmpItemKindFunction = { fg = palette.bg3, bg = palette.orange }
					hl.CmpItemKindStruct = { fg = palette.bg3, bg = palette.orange }
					hl.CmpItemKindClass = { fg = palette.bg3, bg = palette.orange }
					hl.CmpItemKindModule = { fg = palette.bg3, bg = palette.orange }
					hl.CmpItemKindOperator = { fg = palette.bg3, bg = palette.orange }

					hl.CmpItemKindVariable = { fg = palette.bg3, bg = palette.blue }
					hl.CmpItemKindFile = { fg = palette.bg3, bg = palette.blue }

					hl.CmpItemKindUnit = { fg = palette.bg3, bg = palette.red }
					hl.CmpItemKindSnippet = { fg = palette.bg3, bg = palette.red }
					hl.CmpItemKindFolder = { fg = palette.bg3, bg = palette.red }

					hl.CmpItemKindMethod = { fg = palette.bg3, bg = palette.aqua }
					hl.CmpItemKindValue = { fg = palette.bg3, bg = palette.aqua }
					hl.CmpItemKindEnumMember = { fg = palette.bg3, bg = palette.aqua }

					hl.CmpItemKindInterface = { fg = palette.bg3, bg = palette.bg_blue }
					hl.CmpItemKindColor = { fg = palette.bg3, bg = palette.bg_blue }
					hl.CmpItemKindTypeParameter = { fg = palette.bg3, bg = palette.bg_blue }
				end,
			})
		end,
		init = function()
			vim.cmd("colorscheme everforest")
		end,
	},

	{
		"mcchrish/zenbones.nvim",
		enabled = false,
		lazy = false,
		dependencies = "rktjmp/lush.nvim",
		init = function()
			vim.g.rosebones = {
				solid_line_nr = false,
				solid_vert_split = false,
				lighten_noncurrent_window = true,
				italic_comments = true,
			}
			vim.cmd("colorscheme " .. Config.theme)
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = Config.theme == "rose-pine",
		init = function()
			vim.cmd("colorscheme rose-pine")
		end,
		config = function()
			require("rose-pine").setup({
				dim_inactive_windows = false,
			})
		end,
	},

	{
		"p00f/alabaster.nvim",
		enabled = Config.theme == "alabaster",
		init = function()
			vim.cmd("colorscheme alabaster")
		end,
	},
}

local opts = {
	ui = {
		size = { width = 0.9, height = 0.8 },
		border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	},
	install = {
		colorscheme = { Config.theme, "habamax" },
	},
}

require("lazy").setup(plugins, opts)
