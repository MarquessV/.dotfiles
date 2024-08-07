return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
		"lawrence-laz/neotest-zig",
	},
	ft = { "python", "go", "rust", "zig" },
	keys = {
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run the nearest test",
		},
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle()
			end,
			desc = "Toggle watch the nearest test",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug the nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run tests in this file",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run tests in this file",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop the nearest test",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop the nearest test",
		},
		{
			"<leader>tus",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary window",
		},
		{
			"<leader>tuo",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Toggle test output window",
		},
		{
			"<leader>tup",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle test output panel",
		},
	},
	config = function()
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-go")({
					experimental = {
						test_table = true,
					},
				}),
				require("rustaceanvim.neotest"),
				require("neotest-zig"),
			},
		})
	end,
	lazy = false,
}
