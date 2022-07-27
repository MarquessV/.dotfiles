local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- go
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.stylua, -- lua
        null_ls.builtins.code_actions.gitsigns, -- git
        null_ls.builtins.diagnostics.hadolint, -- docker
        null_ls.builtins.diagnostics.jsonlint -- json
    }
})
