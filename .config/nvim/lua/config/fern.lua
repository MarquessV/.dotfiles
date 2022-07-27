vim.g["fern#renderer"] = "nerdfont"
vim.g["fern#default_hidden"] = 1
vim.g.fern_disable_startup_warnings = 1

local function init_fern()
	local opts = {}
	-- Persists Kitty Navigation Keymaps
	vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "<cmd>KittyNavigateRight<cr>", opts)
	vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", "<cmd>KittyNavigateLeft<cr>", opts)
	vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", "<cmd>KittyNavigateDown<cr>", opts)
	vim.api.nvim_buf_set_keymap(0, "n", "<C-k>", "<cmd>KittyNavigateUp<cr>", opts)

	-- Move up directory with '-'
	vim.api.nvim_buf_set_keymap(0, "n", "-", "<plug>(fern-action-leave)", opts)

	vim.cmd([[nmap <buffer><expr> <Plug>(fern-my-open-or-expand)
	      \ fern#smart#leaf(
	      \   "<Plug>(fern-action-open)",
	      \   "<Plug>(fern-action-expand)",
		  \   "<Plug>(fern-action-collapse)",
	      \)]])

	-- Open split with same binding as Telescope
	vim.api.nvim_buf_set_keymap(0, "n", "<C-v>", '<plug>(fern-action-open:side)', opts)

	-- Toggle leaf under cursor
	vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", '<plug>(fern-my-open-or-expand)', opts)

	-- Use netrw mappings
	vim.api.nvim_buf_set_keymap(0, "n", "d", "<plug>(fern-action-new-dir)", opts)
	vim.api.nvim_buf_set_keymap(0, "n", "%", "<plug>(fern-action-new-file)", opts)
end

local fern_group = vim.api.nvim_create_augroup("config_fern", { clear = true })
vim.api.nvim_create_autocmd(
	"FileType",
	{
		pattern = { "fern" },
		group = fern_group,
		callback = init_fern
	}
)
