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
}

require("neotest").setup(default_neotest_config)

local config = {}

function config.update_default(updated_config)
	local merged_config = vim.tbl_extend("keep", updated_config, default_neotest_config)
	require("neotest").setup(merged_config)
end

return config
