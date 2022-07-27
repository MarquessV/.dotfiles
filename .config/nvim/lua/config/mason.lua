require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua", "rust_analyzer", "gopls", "kotlin-language-server",
        "pyright"
    }
})

require('mason-tool-installer').setup({
    ensure_installed = {
        'golangci-lint', 'delve', 'stylua', 'hadolint'
    },
    run_on_start = true
})
