return {
	"folke/which-key.nvim",
	dependencies = {
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = true,
	},
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			win = {
				border = "none",
				wo = {
					winblend = 25,
				},
			},
		})

		local trouble = require("trouble")
		local telescope_builtin = require("telescope.builtin")
		local wrap_func = Config.wrap_func
		local toggle_background = function()
			if vim.o.background == "dark" then
				vim.cmd("set bg=light")
			else
				vim.cmd("set bg=dark")
			end
		end

		-- Search inside visually highlighted text. Use `silent = false` for it to
		-- make effect immediately.
		vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

		vim.keymap.set({ "n" }, "L", "$", { desc = "Go to end of line." })
		vim.keymap.set({ "n" }, "H", "^", { desc = "Go to beginning of line." })

		vim.keymap.set({ "n" }, "<C-u>", "<C-u>zz", { desc = "Page down." })
		vim.keymap.set({ "n" }, "<C-d>", "<C-d>zz", { desc = "Page up." })
		vim.keymap.set({ "n" }, "<C-o>", "<C-o>zz", { desc = "Previous location." })
		vim.keymap.set({ "n" }, "<C-i>", "<C-i>zz", { desc = "Next location." })
		vim.keymap.set({ "n" }, "esc", ":w", { desc = "Save file." })
		vim.keymap.set({ "n" }, "U", "<C-r>", { desc = "Redo." })
		vim.keymap.set({ "n" }, "<Left>", wrap_func(trouble.previous, { skip_group = true, jump = true }))
		vim.keymap.set({ "n" }, "<Right>", wrap_func(trouble.next, { skip_group = true, jump = true }))
		vim.keymap.set({ "n" }, "<Up>", "<Cmd>TSTextobjectGotoPreviousStart @function.outer<cr>")
		vim.keymap.set({ "n" }, "<Down>", "<Cmd>TSTextobjectGotoNextStart @function.outer<cr>")
		vim.keymap.set({ "n" }, "<Left>", "<Cmd>TSTextobjectGotoPreviousStart @class.inner<cr>")
		vim.keymap.set({ "n" }, "<Right>", "<Cmd>TSTextobjectGotoNextStart @class.inner<cr>")
		vim.keymap.set({ "n" }, "W", "<Cmd>TSTextobjectGotoNextStart @parameter.inner<cr>")
		vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
		vim.keymap.set("n", "gp", '"+p', { desc = "Paste from system clipboard" })
		vim.keymap.set("x", "gp", '"+P', { desc = "Paste from system clipboard" })

		-- Leader key mappings
		wk.add({
			{ "<leader>d", group = "[D]ebugging..." },
			{ "<leader>t", group = "[T]esting..." },
			{ "<leader>e", vim.diagnostic.open_float, desc = "Open [e]rror diagnostic in float." },
			{ "<leader>n", group = "[N]ext..." },
			{ "<leader>na", "<Cmd>TSTextobjectGotoNextStart @assignment.outer<cr>", desc = "Go to next [a]ssignment." },
			{ "<leader>nb", "<Cmd>TSTextobjectGotoNextStart @block.outer<cr>", desc = "Go to next [b]lock." },
			{ "<leader>nc", "<Cmd>TSTextobjectGotoNextStart @class.outer<cr>", desc = "Go to next [c]lass." },
			{ "<leader>nd", vim.diagnostic.goto_next, desc = "Go to next [d]iagnostic message." },
			{ "<leader>np", vim.diagnostic.goto_prev, desc = "Go to next [d]iagnostic message." },
			{ "<leader>nl", "<Cmd>TSTextobjectGotoNextStart @call.outer<cr>", desc = "Go to next function [c]all." },
			{
				"<leader>nq",
				wrap_func(require("trouble").next, { skip_group = true, jump = true }),
				desc = "Go to next item in [q]uickfix.",
			},
			{ "<leader>nr", "<Cmd>TSTextobjectGotoNextStart @return.outer<cr>", desc = "Go to next [r]eturn." },
			{ "<leader>ns", "<Cmd>TSTextobjectGotoNextStart @statement.outer<cr>", desc = "Go to next [s]tatement." },
			{ "<leader>nt", "<Cmd>TSTextobjectGotoNextStart @attribute.outer<cr>", desc = "Go to next a[t]rribute." },
			{ "<leader>o", group = "[O]tions..." },
			{ "<leader>ob", toggle_background, desc = "Toggle [b]ackground color." },
			{ "<leader>occ", "<cmd>set cursorcolumn!<cr>", desc = "Toggle [c]ursor[c]olumn." },
			{ "<leader>ocl", "<cmd>set cursorline!<cr>", desc = "Toggle [c]ursor[l]ine." },
			{ "<leader>oh", "<cmd>set hlsearch!<cr>", desc = "Toggle [h]lsearch." },
			{ "<leader>or", "<cmd>set relativenumber!<cr>", desc = "Toggle [r]elativenumber." },
			{ "<leader>os", "<cmd>set spell!<cr>", desc = "Toggle [s]pellcheck." },
			{ "<leader>ow", "<cmd>set wrap!<cr>", desc = "Toggle [w]rap." },
			{ "<leader>p", '"0p', desc = "[P]aste last yank." },
			{ "<leader>r", group = "[R]un..." },
			{ "<leader>rm", "<cmd>Make<cr>", desc = "[M]ake" },
			{ "<leader>rr", "<cmd>OverseerRestartLast<cr>", desc = "[R]estart last task." },
			{ "<leader>s", group = "[S]earch..." },
			{ "<leader>s.", telescope_builtin.resume, desc = "[S]earch recent files[.]" },
			{
				"<leader>s/",
				wrap_func(
					telescope_builtin.current_buffer_fuzzy_find,
					require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					})
				),
				desc = "Fuzzy search [/] current buffer.",
			},
			{ "<leader>b", telescope_builtin.buffers, desc = "Search [b]uffers." },
			{ "<leader>sd", telescope_builtin.diagnostics, desc = "[S]earch [d]iagnostics." },
			{ "<leader>sf", telescope_builtin.find_files, desc = "[S]earch [f]iles." },
			{ "<leader>sg", telescope_builtin.live_grep, desc = "[S]earch with [g]rep." },
			{ "<leader>sh", telescope_builtin.help_tags, desc = "[S]earch [h]elp." },
			{ "<leader>sk", telescope_builtin.keymaps, desc = "[S]earch [k]eymaps." },
			{ "<leader>sr", telescope_builtin.resume, desc = "[S]earch [r]esume." },
			{ "<leader>ss", telescope_builtin.builtin, desc = "[S]earch picker [s]elections." },
			{ "<leader>sw", telescope_builtin.grep_string, desc = "[S]earch current [w]ord." },
			{ "<leader>x", group = "Quickfi[x]..." },
			{ "<leader>xd", vim.diagnostic.setqflist, desc = "Send diagnostics to quickfix list" },
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false win.width=120<cr>",
				desc = "Send diagnostics to quickfix list",
			},
			{ "<leader>xl", wrap_func(trouble.toggle, "loclist"), desc = "[L]oclist" },
			{ "<leader>xq", wrap_func(trouble.toggle, "quickfix"), desc = "[Q]uickfix" },
			{ "<leader>xt", require("lsp_lines").toggle, desc = "[T]oggle LSP Lines" },
			{ "<leader>xw", wrap_func(trouble.toggle, "diagnostics"), desc = "diagnostics" },
			{ "<leader>xx", trouble.toggle, desc = "Toggle Trouble window" },
		})
	end,
}
