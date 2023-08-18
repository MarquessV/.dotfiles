vim.g.zenbones = {
	lighten_non_current_window = true,
	colorize_diagnostic_underline_text = false,
}

M = {
	apply_extra_highlights = function()
		vim.cmd([[highlight link IndentBlanklineContextChar Function]])

		vim.cmd([[highlight link @property @lsp.type.property]])
		vim.cmd([[highlight @lsp.type.property guifg=#d3c6aa gui=bold]])

		vim.cmd([[highlight link @lsp.type.enumMember @lsp.type.property]])
		vim.cmd([[highlight link @enumMember @lsp.type.enumMember]])

		vim.cmd([[highlight @lsp.typemod.variable.declaration guifg=#d3c6aa gui=italic]])
		vim.cmd([[highlight @lsp.type.variable guifg=#d3c6aa]])
		vim.cmd([[highlight link @variable @lsp.type.variable]])

		vim.cmd([[highlight @lsp.type.string guifg=#a7c080]])
		vim.cmd([[highlight link @string @lsp.type.string]])

		vim.cmd([[highlight @lsp.type.boolean guifg=#d699b6]])
		vim.cmd([[highlight link @boolean @lsp.type.boolean]])

		vim.cmd([[highlight @lsp.type.keyword guifg=#e67e80 gui=bold]])
		vim.cmd([[highlight link @keyword @lsp.type.keyword]])

		vim.cmd([[highlight @lsp.type.operator guifg=#e69875]])
		vim.cmd([[highlight link @operator @lsp.type.operator]])

		vim.cmd([[highlight @lsp.type.type guifg=#dbbc7f]])
		vim.cmd([[highlight link @type @lsp.type.type]])

		vim.cmd([[highlight @lsp.type.namespace guifg=#dbbc7f gui=bold]])
		vim.cmd([[highlight link @namespace @lsp.type.namespace]])

		vim.cmd([[highlight @lsp.type.macro guifg=#83c092]])
		vim.cmd([[highlight link @macro @lsp.type.macro]])

		vim.cmd([[highlight @lsp.type.enum guifg=#e69875]])
		vim.cmd([[highlight link @enum @lsp.type.enum]])

		vim.cmd([[highlight @lsp.type.decorator guifg=#d699b6 gui=italic]])
		vim.cmd([[highlight link @decorator @lsp.type.decorator]])

		vim.cmd([[highlight link @lsp.type.struct @lsp.type.enum]])
		vim.cmd([[highlight link @struct @lsp.type.struct]])

		vim.cmd([[highlight link @lsp.type.interface @lsp.type.type]])
		vim.cmd([[highlight link @interface @lsp.type.interface]])

		vim.cmd([[highlight @lsp.type.method.declaration guifg=#a7c080 gui=bold]])
		vim.cmd([[highlight link @method.declaration @lsp.type.method.declaration]])

		vim.cmd([[highlight @lsp.type.method guifg=#a7c080]])
		vim.cmd([[highlight link @method @lsp.type.method]])

		vim.cmd([[highlight @lsp.type.selfKeyword guifg=#7fbbb3 gui=italic]])
		vim.cmd([[highlight link @selfKeyword @lsp.type.selfKeyword]])

		vim.cmd([[highlight link @lsp.type.parameter @lsp.typemod.variable.declaration]])
	end,
}

return M
