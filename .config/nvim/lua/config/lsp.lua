local common_config = {
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	},
}

function TelescopeSymbolFinder()
	local lsp_symbols = vim.tbl_map(string.lower, vim.lsp.protocol.SymbolKind)
	require("telescope.builtin").lsp_dynamic_workspace_symbols({ symbols = lsp_symbols })
end

-- LSP settings (for overriding per client)
local function key_maps(bufnr, extra)
	extra = extra or {}

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
					function()
						vim.diagnostic.open_float({ scope = "line", focusable = false, border = "rounded" })
					end,
					"Show Line Diagnostics",
				},
			},
		},
		["<C-;>"] = {
			"<cmd>lua TelescopeSymbolFinder()<CR>",
			"Find symbols",
		},
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostics" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostics" },
	}

	local wk = require("which-key")
	wk.register(maps, opts)
	wk.register(extra, opts)
end

local function document_highlight(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		local lsp_document_highlight = vim.api.nvim_create_augroup("config_lsp_document_highlight", {})
		vim.opt.updatetime = 1000
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

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		-- filter = function(client)
		-- 	return client.name == "null-ls" or client.name == "pylsp"
		-- end,
		bufnr = bufnr,
		timeout_ms = 10000,
		async = true,
	})
end

local null_ls_augroup = vim.api.nvim_create_augroup("lsp_formatting", {})
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
		document_highlight(client, bufnr)
	end

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

	vim.lsp.handlers["textDocument/publishDiagnostics"] =
		vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = false })

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		hint_prefix = " ",
	}, bufnr)
end

-- Needs to be setup before lspconfig
require("mason").setup()
require("mason-lspconfig").setup()
require("neodev").setup({
	library = { plugins = true, types = true },
})

-- cmp lsp
common_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Diagnostics
vim.diagnostic.config({ virtual_lines = false, virtual_text = true, signs = true })

-- null-ls for diagnostics from static checkers and formatting
local null_ls = require("null-ls")
null_ls.setup({
	on_attach = common_config.on_attach,
	sources = {
		-- go
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.formatting.stylua, -- lualsp
		null_ls.builtins.diagnostics.hadolint, -- docker
		null_ls.builtins.diagnostics.jsonlint, -- json
		-- null_ls.builtins.formatting.taplo, -- toml
		null_ls.builtins.formatting.rustfmt.with({
			extra_args = { "--edition=2021" },
		}), -- rust
		null_ls.builtins.diagnostics.ktlint, -- kotlin
		-- prose
		null_ls.builtins.diagnostics.vale.with({
			filetypes = { "markdown", "tex", "text", "rst" },
		}),
	},
})

-- Server Configurations
require("lspconfig").lua_ls.setup({
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	handlers = common_config.handlers,
	filetypes = { "lua" },
	rootPatterns = { ".git", "init.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = { globals = { "vim", "Config" } },
			telemetry = { enable = false },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

local python_root_files = {
	"setup.py",
	"setup.cfg",
	"pyproject.toml",
	"requirements.txt",
	"pyrightconfig.json",
}

-- require("lspconfig").pyright.setup({
-- 	on_attach = common_config.on_attach,
-- 	capabilities = common_config.capabilities,
-- 	handlers = common_config.handlers,
-- 	filetypes = { "python" },
-- 	root_dir = require("lspconfig").util.root_pattern(unpack(python_root_files)),
-- 	rootPatterns = python_root_files,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				autoSearchPaths = true,
-- 				typeCheckingMode = "basic",
-- 				reportUnusedImport = true,
-- 				autoImportCompletions = true,
-- 				useLibraryCodeForTypes = false,
-- 				diagnosticMode = "workspace",
-- 			},
-- 		},
-- 	},
-- })

require("lspconfig").pylsp.setup({
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	handlers = common_config.handlers,
	filetypes = { "python" },
	root_dir = require("lspconfig").util.root_pattern(unpack(python_root_files)),
	rootPatterns = python_root_files,
	settings = {
		pylsp = {
			plugins = {
				autopep8 = { enabled = false },
				mccabe = { enabled = false },
				pycodestyle = {
					enabled = false,
				},
				yapf = {
					enabled = false,
				},
				pylsp_mypy = {
					enabled = true,
					live_mode = false,
					dmypy = true,
					report_progress = true,
				},
				black = {
					enabled = true,
				},
				pylsp_black = {
					enabled = true,
				},
				pylsp_ruff = {
					enabled = true,
					extendSelect = {
						"F",
						"I",
						"C90",
						"I",
						"D",
						"UP",
						"S",
						"B",
						"C4",
						"PT",
						"RET",
						"SLF",
						"SIM",
						"TCH",
						"ARG",
						"FIX",
						"PL",
						"NPY",
						"PERF",
					},
				},
			},
		},
	},
})

require("lspconfig").kotlin_language_server.setup({
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	handlers = common_config.handlers,
	rootPatterns = { ".git", "settings.gradle" },
})

require("lspconfig").gopls.setup({
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	handlers = common_config.handlers,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = { unusedparams = true, shadow = true },
			staticcheck = true,
		},
	},
	init_options = { usePlaceholders = true },
})

require("lspconfig").yamlls.setup({
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	handlers = common_config.handlers,
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "./.github/workflows/*",
			},
		},
	},
})

require("lspconfig").cssls.setup({
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	handlers = common_config.handlers,
	settings = {},
})

require("lspconfig").jsonls.setup({
	on_attach = common_config.on_attach,
	capabilities = common_config.capabilities,
	handlers = common_config.handlers,
	settings = {},
})

-- Update this path
local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

local rt = require("rust-tools")
rt.setup({
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = true,
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
		},
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
	server = {
		on_attach = common_config.on_attach,
		capabilities = common_config.capabilities,
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					buildScripts = {
						enable = true,
					},
				},
				checkOnSave = {
					enable = true,
					command = "clippy",
				},
				diagnostics = {
					experimental = {
						enable = false,
					},
				},
				inlayHints = {
					lifetimeElisionHints = {
						enable = true,
						useParameterNames = true,
					},
				},
			},
		},
	},
})
