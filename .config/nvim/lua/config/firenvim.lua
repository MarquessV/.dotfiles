vim.g.firenvim_config = {
	localSettings = {
		[".*"] = { cmdline = "neovim", priority = 0, takeover = "always" },
	},
}

vim.api.nvim_create_autocmd({ "UIEnter" }, {
	callback = function(_)
		local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
		if client ~= nil and client.name == "Firenvim" then
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				pattern = "git(hub|lab).com_*.txt",
				command = "set filetype=markdown",
			})
			vim.o.laststatus = 0
			vim.o.cmdheight = 0
			vim.o.guifont = "Iosevka,Hack Nerd Font Mono"
		end
	end,
})
