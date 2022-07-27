local common_config = {}

local function key_maps(bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { buffer = bufnr, noremap = true, silent = true }

	local maps = {
		["<leader>"] = {
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
				d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
				D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
				i = {
					"<cmd>lua vim.lsp.buf.implementation()<CR>",
					"Implementation",
				},
				k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
				h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Help" },
				n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
				r = { "<cmd>Trouble lsp_references<CR>", "References" },
				f = { "<cmd>Telescope grep_string<CR>", "Find Word" },
				l = {
					"<cmd>lua vim.diagnostic.open_float({scope = 'line'})<CR>",
					"Show Line Diagnostics",
				},
				x = {
					name = "Diagnostics",
					d = {
						"<cmd>Trouble document_diagnostics<cr>",
						"Show Document Diagnostics",
					},
					w = {
						"<cmd>Trouble workspace_diagnostics<cr>",
						"Show Workspace Diagnostics",
					},
				},
			},
		},
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostics" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostics" },
	}

	require("which-key").register(maps, opts)
end

local function documentHighlight(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		local lsp_document_highlight = vim.api.nvim_create_augroup("config_lsp_document_highlight", { clear = false })
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = lsp_document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
			group = lsp_document_highlight,
			buffer = 0,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				vim.lsp.buf.clear_references()
			end,
			group = lsp_document_highlight,
			buffer = 0,
		})
	end
end

local function lsp_formatting(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

function common_config.on_attach(client, bufnr)
	key_maps(bufnr)
	local lsp_hover_augroup = vim.api.nvim_create_augroup("config_lsp_hover", { clear = false })
	vim.api.nvim_clear_autocmds({ buffer = bufnr, group = lsp_hover_augroup })
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				if vim.api.nvim_win_get_config(winid).relative ~= "" then
					return
				end
			end
			vim.diagnostic.open_float()
		end,
		group = lsp_hover_augroup,
		buffer = bufnr,
	})
	if Config.lsp.highlight then
		documentHighlight(client, bufnr)
	end

	local null_ls_augroup = vim.api.nvim_create_augroup("lsp_formatting", {})
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = null_ls_augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = null_ls_augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	require("nvim-navic").attach(client, bufnr)
end

-- cmp lsp
common_config.capabilities = vim.lsp.protocol.make_client_capabilities()
common_config.capabilities = require("cmp_nvim_lsp").update_capabilities(common_config.capabilities)

-- Diagnostics
vim.diagnostic.config({ virtual_text = true, signs = true })

-- Server Configurations
require("lspconfig").sumneko_lua.setup({
	cmd = { "lua-language-server" },
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "lua" },
	rootPatterns = { ".git", "init.lua" },
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "Config" } },
			telemetry = { enable = false },
		},
	},
})

require("lspconfig").pyright.setup({
	cmd = { "pyright-langserver", "--stdio" },
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "python" },
	rootPatterns = {
		".git",
		"setup.py",
		"setup.cfg",
		"pyproject.toml",
		"requirements.txt",
		"tab_bar.py",
	},
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				reportUnusedImport = true,
				autoImportCompletions = true,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
})

require("lspconfig").kotlin_language_server.setup({
	cmd = { "kotlin-language-server" },
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "kotlin" },
	rootPatterns = { ".git", "settings.gradle" },
})

require("lspconfig").gopls.setup({
	cmd = { "gopls" },
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = { unusedparams = true, shadow = true },
			staticcheck = true,
		},
	},
	init_options = { usePlaceholders = true },
})
