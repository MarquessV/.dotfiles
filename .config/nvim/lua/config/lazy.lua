require("lazy").setup({
	-- Plugin Dependency Management
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
		config = function()
			require("config.mason")
		end,
	},

	-- Load config faster
	{ "lewis6991/impatient.nvim", lazy = false, priority = 100 },

	-- UI Improvements
	{
		"stevearc/dressing.nvim",
		config = function()
			require("config.dressing")
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
	{ "SmiteshP/nvim-navic", dependencies = { "neovim/nvim-lspconfig" } },

	-- Git
	{ "tpope/vim-fugitive" },

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
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		-- since they are related, config is in config.lsp
	},

	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("config.symbols-outline")
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

	-- Kotlin
	{ "udalov/kotlin-vim" },

	-- Better Quickfix List
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("config.trouble")
		end,
	},

	-- LSP Setting management, config in lsp.lua
	{ "folke/neoconf.nvim" },

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
	{ "mfussenegger/nvim-dap" },

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},

	-- Keymap documentation
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
	},

	-- Completion for neovim lua - config in lsp.lua
	{ "folke/neodev.nvim" },

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
	-- Config w/ Telescope
	{ "nvim-telescope/telescope-file-browser.nvim" },

	-- Interactive scratchpad
	{ "metakirby5/codi.vim" },

	{
		"ggandor/leap.nvim",
		config = function()
			require("config.leap")
		end,
	},

	-- Smooth scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("config.neoscroll")
		end,
	},

	-- Colorscheme
	{
		"neanias/everforest-nvim",
		config = function()
			require("config.everforest")
		end,
	},

	-- Markdown Previews
	{ "ellisonleao/glow.nvim" },

	-- Kitty support
	{ "fladson/vim-kitty" }, -- config syntax highlighting
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
}, {
	lazy = true,
})
