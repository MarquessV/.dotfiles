local default_neotest_config = {
	adapters = {
		require("neotest-go"),
		require("neotest-rust"),
		require("neotest-python"),
	},
	quickfix = {
		open = function()
			vim.cmd("Trouble quickfix")
		end,
	},
	highlights = {
		adapter_name = "Comment",
		border = "FloatBorder",
		dir = "Directory",
		expand_marker = "Normal",
		failed = "DiagnosticError",
		file = "Function",
		focused = "DiagnosticUnderlineInfo",
		marked = "NeotestMarked",
		namespace = "Identifier",
		passed = "DiagnosticOk",
		running = "DiagnosticWarn",
		select_win = "Function",
		skipped = "DiagnoticInfo",
		target = "NeotestTarget",
		test = "Constant",
		unknown = "NeotestUnknown",
	},
	output = {
		open_on_run = false,
	},
	summary = {
		mappings = {
			expand = { "<Tab>" },
		},
	},
}

require("neotest").setup(default_neotest_config)

local config = {}

function config.update_default(updated_config)
	local merged_config = vim.tbl_extend("keep", updated_config, default_neotest_config)
	require("neotest").setup(merged_config)
end

return config
