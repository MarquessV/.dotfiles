require("lazy").setup({
	-- Plugin Dependency Management
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		config = function()
			require("config.mason")
		end,
		lazy = false,
		priority = 49,
	},

	-- UI Improvements
	{
		"stevearc/dressing.nvim",
		config = function()
			require("config.dressing")
		end,
	},

	{
		"folke/noice.nvim",
		config = function()
			require("config.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- "rcarriga/nvim-notify",
		},
		enabled = false,
	},

	{
		"echasnovski/mini.animate",
		version = false,
		config = function()
			require("config.mini-animate")
		end,
	},

	{
		"echasnovski/mini.sessions",
		version = false,
		config = function()
			require("mini.sessions").setup({ autoread = false, autowrite = true })
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config.nvim-treesitter")
		end,
	},

	{
		"nvim-treesitter/playground",
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	},

	-- Pipe location from lsp to lualine
	{ "SmiteshP/nvim-navic", dependencies = { "neovim/nvim-lspconfig" } },

	-- LSP status
	{
		"j-hui/fidget.nvim",
		config = function()
			require("config.fidget")
		end,
	},

	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		config = function()
			require("config.neogit")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns")
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
		lazy = false,
		priority = 50,
	},

	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		-- since they are related, config is in config.lsp
	},

	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("config.copilot")
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Language Support
	-- Go
	{
		"olexsmir/gopher.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("config.gopher")
		end,
	},

	-- Rust
	-- Really just a preconfigured LSP, so init is in `config.lsp`
	{ "simrat39/rust-tools.nvim" },

	{
		"Saecki/crates.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},

	-- Better Quickfix List
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("config.trouble")
		end,
	},

	-- Completion for neovim lua - config in lsp.lua
	{ "folke/neodev.nvim" },

	-- Unit Tests
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
		},
		config = function()
			require("config.neotest")
		end,
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("config.nvim-dap")
		end,
		lazy = false,
		dependencies = {
			{ "rcarriga/nvim-dap-ui", lazy = false },
			{ "theHamsta/nvim-dap-virtual-text", lazy = false },
			{ "mfussenegger/nvim-dap-python", lazy = false },
		},
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"petertriho/cmp-git",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		-- config in lsp.lua.on_attach
	},

	-- Keymap documentation
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
		config = function()
			require("config.nvim-autopairs")
		end,
	},

	-- Comments
	{
		"terrortylor/nvim-comment",
		config = function()
			require("config.nvim-comment")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.indent-blankline")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		config = function()
			require("config.telescope")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
	},

	{
		"stevearc/overseer.nvim",
		config = function()
			require("config.overseer")
		end,
	},

	{
		"ggandor/leap.nvim",
		config = function()
			require("config.leap")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			require("config.harpoon")
		end,
	},

	-- Markdown Previews
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},

	-- Kitty support
	{
		"fladson/vim-kitty", -- config syntax highlighting
	},

	{ "knubie/vim-kitty-navigator", build = "cp ./*.py ~/.config/kitty/" },

	-- Show color of hex codes
	{ "norcalli/nvim-colorizer.lua" },

	-- Surround motion
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("config.surround")
		end,
	},

	-- Colorschemes
	{
		"https://github.com/AlexvZyl/nordic.nvim",
		config = function()
			require("config.nordic")
		end,
		lazy = false,
		priority = 99,
		enabled = Config.theme == "nordic",
	},
}, {
	lazy = true,
})
