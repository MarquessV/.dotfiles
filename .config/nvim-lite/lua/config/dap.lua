return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{
			"<leader>dt",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle dap UI",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<leader>df",
			function()
				require("dapui").float_element()
			end,
			desc = "Float info",
		},
		{
			"<leader>de",
			function()
				require("dapui").eval()
			end,
			mode = { "n", "v" },
			desc = "Eval expression under cursor",
		},
	},
	config = function()
		require("nvim-dap-virtual-text").setup()

		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		local dap_python = require("dap-python")
		dap_python.setup("~/dev/virtualenvs/debugpy/bin/python")
		dap_python.test_runner = "pytest"

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.zig = {
			{
				type = "codelldb",
				name = "Debug",
				request = "launch",
				cwd = "${workspaceFolder}",
				program = "./zig-out/bin/gengine",
			},
		}

		require("dap-go").setup({
			build_flags = "-tags unit -mod mod -gcflags '-tags unit'",
			buildFlags = "-tags unit -mod mod -gcflags '-tags unit'",
			dap_configurations = {
				{
					name = "Run test file",
					type = "go",
					request = "launch",
					mode = "test",
					program = "${fileDirname}",
				},
			},
		})
		require("dap.ext.vscode").json_decode = require("overseer.json").decode
		require("overseer").patch_dap(true)
	end,
	lazy = false,
}
