local packer = require("packer")

local plugins = packer.startup({
	function(use)
		-- Packer
		use({ "wbthomason/packer.nvim" })

		-- Plugin Dependency Management
		use({
			"williamboman/mason.nvim",
			requires = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
			config = [[require("config.mason")]],
		})

		-- Load config faster
		use({ "lewis6991/impatient.nvim" })

		-- UI Improvements
		use({ "stevearc/dressing.nvim", config = [[require("config.dressing")]] })

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = [[require("config.nvim-treesitter")]],
		})

		use({
			"nvim-treesitter/playground",
		})

		-- Statusline
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require("config.lualine")]],
		})
		use({ "SmiteshP/nvim-navic", requires = { "neovim/nvim-lspconfig" } })

		-- Git
		use({ "tpope/vim-fugitive" })

		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = [[require("config.gitsigns")]],
		})

		-- LSP
		use({ "neovim/nvim-lspconfig", config = [[require("config.lsp")]] })

		use({
			"jose-elias-alvarez/null-ls.nvim",
			-- since they are related, config is in config.lsp
		})

		use({
			"simrat39/symbols-outline.nvim",
			config = [[require("config.symbols-outline")]],
		})

		-- Language Support
		-- Go
		use({
			"olexsmir/gopher.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
			config = [[require("config.gopher")]],
		})

		-- Rust
		-- Really just a preconfigured LSP, so setup is in `config.lsp`
		use({ "simrat39/rust-tools.nvim" })

		-- Kotlin
		use({ "udalov/kotlin-vim" })

		-- Better Quickfix List
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = [[require("config.trouble")]],
		})

		-- LSP Setting management, config in lsp.lua
		use({ "folke/neoconf.nvim" })

		-- Unit Tests
		use({
			"nvim-neotest/neotest",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/neotest-go",
				"nvim-neotest/neotest-python",
				"rouge8/neotest-rust",
			},
			config = [[require("config.neotest")]],
		})

		-- Debugging
		use({ "mfussenegger/nvim-dap" })

		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			requires = {
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
			config = [[require("config.nvim-cmp")]],
		})

		-- Keymap documentation
		use({ "folke/which-key.nvim", config = [[require("config.which-key")]] })

		-- Completion for neovim lua - config in lsp.lua
		use("folke/neodev.nvim")

		-- Autopairs
		use({
			"windwp/nvim-autopairs",
			requires = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
			config = [[require("config.nvim-autopairs")]],
		})

		-- Comments
		use({
			"terrortylor/nvim-comment",
			config = [[require("config.nvim-comment")]],
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			config = [[require("config.indent-blankline")]],
		})

		-- File Management
		-- use({
		-- 	"lambdalisue/fern.vim",
		-- 	requires = {
		-- 		{ "lambdalisue/nerdfont.vim" },
		-- 		{ "lambdalisue/fern-renderer-nerdfont.vim" },
		-- 		{ "yuki-yano/fern-preview.vim" },
		-- 		{ "lambdalisue/fern-hijack.vim" },
		-- 		{ "lambdalisue/fern-mapping-project-top.vim" },
		-- 		{ "lambdalisue/fern-git-status.vim" },
		-- 		{ "lambdalisue/fern-mapping-git.vim" },
		-- 	},
		-- 	config = [[require("config.fern")]],
		-- })
		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			requires = {
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				{ "nvim-telescope/telescope-fzy-native.nvim" },
			},
			config = [[require("config.telescope")]],
		})
		-- Config w/ Telescope
		use({ "nvim-telescope/telescope-file-browser.nvim" })

		-- Interactive scratchpad
		use({ "metakirby5/codi.vim" })

		-- Hop
		-- use({
		-- 	"phaazon/hop.nvim",
		-- 	branch = "v2",
		-- 	config = [[require("config.hop")]],
		-- })

		use({
			"ggandor/leap.nvim",
			config = [[require("config.leap")]],
		})

		-- Smooth scrolling
		use({ "karb94/neoscroll.nvim", config = [[require("config.neoscroll")]] })

		-- Markdown Previews
		use({ "ellisonleao/glow.nvim" })

		-- Kitty support
		use({ "fladson/vim-kitty" }) -- config syntax highlighting
		use({ "knubie/vim-kitty-navigator", run = "cp ./*.py ~/.config/kitty/" })

		-- Show color of hex codes
		use({ "norcalli/nvim-colorizer.lua" })

		-- Surround motion
		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = [[require("config.surround")]],
		})

		-- Colorschemes
		use({
			"daschw/leaf.nvim",
			config = [[require("config.leaf")]],
		})

		use({
			"EdenEast/nightfox.nvim",
			config = [[require("config.nightfox")]],
			run = ":NightfoxCompile",
		})

		use({
			"kartikp10/noctis.nvim",
			requires = { "rktjmp/lush.nvim" },
		})

		use({
			"savq/melange",
			config = [[require("config.melange")]],
		})

		use({
			"neanias/everforest-nvim",
			config = [[require("config.everforest")]],
		})
	end,
})

return plugins
