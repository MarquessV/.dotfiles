local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

require("nvim-dap-virtual-text").setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require("dap-python").setup()

dap.adapters.codelldb = {
	type = "server",
	port = "13000",
	executable = {
		command = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/adapter/codelldb",
		args = { "--port", "13000" },
	},
}
