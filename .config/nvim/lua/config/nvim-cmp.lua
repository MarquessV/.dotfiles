local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
lspkind.init()

local sources = {
	path = "[Path]",
	nvim_lua = "[Lua]",
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	luasnip = "[Snip]"
}

vim.opt.shortmess:append('c')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)	
		end,
	},
	completion = {
		completeopt = "menu,menuone,noselect"
	},
	window = {
		documentation = {
			border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
		}
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol',
			maxwidth = 120,
			before = function(entry, vim_item)
				return vim_item
			end
		})
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			  if cmp.visible() then
				cmp.select_next_item()
			  elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			  elseif has_words_before() then
				cmp.complete()
			  else
				fallback()
			  end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			  if cmp.visible() then
				cmp.select_prev_item()
			  elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			  else
				fallback()
			  end
		end, { "i", "s" })
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help"} ,
		{ name = "buffer" },
		{ name = "luasnip" },
	}
})

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = ''
			return vim_item
		end
	},
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = ''
			return vim_item
		end
	},
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Autopairs config
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)