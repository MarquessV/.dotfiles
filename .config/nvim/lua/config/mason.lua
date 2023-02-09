require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"gopls",
		"kotlin_language_server",
		"pyright",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"golangci-lint",
		"delve",
		"stylua",
		"hadolint",
		"flake8",
		"black",
	},
	run_on_start = true,
})
