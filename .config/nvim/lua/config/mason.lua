require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"gopls",
		"kotlin_language_server",
		"pyright",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"golangci-lint",
		"stylua",
		"flake8",
		"black",
		"mypy",
		"ruff",
	},
})
