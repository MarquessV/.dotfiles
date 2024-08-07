return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
			"lukas-reineke/cmp-under-comparator",
			"SmiteshP/nvim-navic",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			{
				"rachartier/tiny-code-action.nvim",
				event = "LspAttach",
				config = function()
					require("tiny-code-action").setup()
				end,
			},

			"petertriho/cmp-git",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"zbirenbaum/copilot-cmp",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				version = "2.*",
				config = function()
					local ls = require("luasnip")
					vim.keymap.set({ "i" }, "<C-K>", function()
						ls.expand()
					end, { silent = true })
					vim.keymap.set({ "i", "s" }, "<C-L>", function()
						ls.jump(1)
					end, { silent = true })
					vim.keymap.set({ "i", "s" }, "<C-J>", function()
						ls.jump(-1)
					end, { silent = true })

					vim.keymap.set({ "i", "s" }, "<C-E>", function()
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end, { silent = true })
				end,
			},
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("copilot_cmp").setup()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y"] = cmp.mapping.confirm({ select = true }),
					["<C-space>"] = cmp.mapping.complete(),
					["<C-esc>"] = cmp.mapping.abort(),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
					["<C-e>"] = cmp.mapping(function()
						if luasnip.choice_active() then
							luasnip.change_choice(1)
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp_signature_help" },
				}, {
					{ name = "buffer", keyword_length = 5 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					border = "rounded",
					expandable_indicator = true,
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
							symbol_map = { Copilot = "" },
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. "  "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
						return kind
					end,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						require("copilot_cmp.comparators").prioritize,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						require("cmp-under-comparator").under,
						cmp.config.compare.kind,
					},
				},
				experimental = {
					native_menu = false,
					ghost_text = false,
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Set up lspconfig.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if not client then
						return
					end

					-- If supported, send symbol hierarchy to navic
					if client.server_capabilities.documentSymbolProvider then
						require("nvim-navic").attach(client, ev.buf)
					end

					-- Highlight symbol under cursor when held
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = ev.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = ev.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- Enable inlay hints
					if client.server_capabilities.inlayHintProvider and vim.fn.has("nvim-0.10") == 1 then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					end

					-- Buffer local mappings.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					-- Global mappings.
					-- See `:help vim.diagnostic.*` for documentation on any of the below functions
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclarations.")
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [d]efinitions.")
					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [i]mplementations.")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [r]eferences.")
					map("K", vim.lsp.buf.hover, "[H]over documentation.")
					map("<C-space>", vim.lsp.buf.signature_help, "Signature help.")
					map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[A]dd [w]orkspace folder.")
					map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[R]emove [w]orkspace folder.")
					map("<leader>D", vim.lsp.buf.type_definition, "Goto type [d]efinition")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame symbol.")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ctions.")
					vim.keymap.set("n", "<leader>ca", function()
						require("tiny-code-action").code_action()
					end, { noremap = true, silent = true })
				end,
			})

			-- Diagnostics config
			local diagnostic_icons = require("config.icons").diagnostics
			for severity, icon in pairs(diagnostic_icons) do
				local hl = "DiagnosticSign" .. severity:sub(1, 1) .. severity:sub(2):lower()
				vim.fn.sign_define(hl, { text = icon, texthl = hl })
			end

			-- Use Telescope highlights for all floating windows
			vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
			vim.api.nvim_set_hl(0, "NormalFloat", { link = "TelescopeNormal" })

			-- Override default floating window behavior to use round borders
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded"
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "",
					-- Show only the first line of each diagnostic.
					format = function(diagnostic)
						local icon = diagnostic_icons[vim.diagnostic.severity[diagnostic.severity]] .. " "
						return icon .. vim.split(diagnostic.message, "\n")[1]
					end,
				},
				float = {
					border = "rounded",
					source = "if_many",
					-- Show severity icons as prefixes.
					prefix = function(diag)
						local level = vim.diagnostic.severity[diag.severity]
						local prefix = string.format(" %s ", diagnostic_icons[level])
						return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
					end,
				},
				signs = false,
			})

			-- Server configs
			lspconfig.pyright.setup({
				capabilities = capabilities,
				handlers = {
					["textDocument/publishDiagnostics"] = function() end,
				},
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "off",
							typeCheckingMode = "off",
						},
					},
				},
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = { globals = { "vim", "Config" } },
						telemetry = { enable = false },
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "space",
								indent_size = 2,
							},
						},
					},
				},
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.ccls.setup({
				capabilities = capabilities,
				init_options = {
					cache = {
						directory = ".ccls-cache",
					},
				},
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			lspconfig.bufls.setup({
				capabilities = capabilities,
			})

			lspconfig.zls.setup({
				capabilities = capabilities,
			})

			lspconfig.glslls.setup({
				capabilities = capabilities,
				cmd = { "glslls", "--stdin", "--target-env", "opengl" },
			})

			lspconfig.tsserver.setup({
				cmd = { "npx", "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"astro",
				},
			})
		end,
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,
				javascript = { "prettierd", "prettier" },
				json = { "jq" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = true,
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			local prose_linters = { "languagetool" }
			lint.linters_by_ft = {
				gitcommit = { "commitlint" },
				dockerfile = { "hadolint" },
				env = { "dotenv" },
				make = { "checkmake" },
				markdown = { unpack(prose_linters) },
				javascript = { "eslint" },
				json = { "jsonlint" },
				lua = { "luacheck" },
				norg = prose_linters,
				proto = { "buf" },
				python = { "ruff", "mypy" },
				rust = { "compiler" },
				rst = { "rstcheck", unpack(prose_linters) },
				sh = { "shellcheck" },
				text = prose_linters,
				yml = { "actionlint", "yamllint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
					require("lint").try_lint({ "typos", "woke" })
				end,
			})
		end,
	},
}
