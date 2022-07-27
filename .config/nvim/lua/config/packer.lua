local packer = require("packer")

local plugins = packer.startup({
    function(use)
        -- Packer
        use {"wbthomason/packer.nvim"}

        -- Plugin Dependency Management
        use {
            "williamboman/mason.nvim",
            requires = {'williamboman/mason-lspconfig.nvim', 'WhoIsSethDaniel/mason-tool-installer.nvim'},
            config = [[require("config.mason")]]
        }

        -- Load config faster
        use {"lewis6991/impatient.nvim"}

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = [[require("config.nvim-treesitter")]]
        }

        -- Statusline
        use {
            'nvim-lualine/lualine.nvim',
            requires = {"kyazdani42/nvim-web-devicons"},
            config = [[require("config.lualine")]]
        }
        use {"SmiteshP/nvim-navic", requires = {"neovim/nvim-lspconfig"}}

        -- Bufferline
        use {
            'akinsho/bufferline.nvim',
            tag = "v2.*",
            requires = {'kyazdani42/nvim-web-devicons'},
            config = [[require("config.bufferline")]]
        }

        -- Git
        use {"tpope/vim-fugitive"}

        use {
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim", opt = true},
            config = [[require("config.gitsigns")]]
        }

        -- LSP
        use {"neovim/nvim-lspconfig", config = [[require("config.lsp")]]}

        use {
            'jose-elias-alvarez/null-ls.nvim',
            config = [[require("config.null-ls")]]
        }

        -- Better Quickfix List
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require("config.trouble")]]
        }

        -- Unit Tests
        use {
            "nvim-neotest/neotest",
            requires = {
                "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim", 'nvim-neotest/neotest-go'

            },
            config = [[require("config.neotest")]]

        }

        -- Debugging
        use {'mfussenegger/nvim-dap'}

        -- Completion
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lsp-signature-help",
                "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip", "onsails/lspkind-nvim"
            },
            config = [[require("config.nvim-cmp")]]
        }

        -- Keymap documentation
        use {"folke/which-key.nvim", config = [[require("config.which-key")]]}

        -- Autopairs
        use {
            "windwp/nvim-autopairs",
            requires = {"nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp"},
            config = [[require("config.nvim-autopairs")]]
        }

        -- Comments
        use {
            "terrortylor/nvim-comment",
            config = [[require("config.nvim-comment")]]
        }

        -- File Management
        use {
            "lambdalisue/fern.vim",
            requires = {
                {"antoinemadec/FixCursorHold.nvim"},
                {"lambdalisue/nerdfont.vim"},
                {"lambdalisue/fern-renderer-nerdfont.vim"},
                {"yuki-yano/fern-preview.vim"}, {"lambdalisue/fern-hijack.vim"},
                {"lambdalisue/fern-mapping-project-top.vim"},
                {"lambdalisue/fern-git-status.vim"},
                {"lambdalisue/fern-mapping-git.vim"}
            },
            config = [[require("config.fern")]]
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            requires = {
                {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
            },
            wants = {"popup.nvim", "plenary.nvim", "telescope-fzf-native.nvim"},
            config = [[require("config.telescope")]]
        }

        -- Hop
        use {
            "phaazon/hop.nvim",
            branch = "v2",
            config = [[require("config.hop")]]
        }

        -- Smooth scrolling, darken inactive splits
        use {'karb94/neoscroll.nvim', config = [[require("config.neoscroll")]]}
        use {'sunjon/shade.nvim', config = [[require("config.shade")]]}

        -- Markdown Previews
        use {'ellisonleao/glow.nvim'}

        -- Kitty support
        use {"fladson/vim-kitty"} -- config syntax highlighting
        use {'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/'}

        -- Show color of hex codes
        use {"norcalli/nvim-colorizer.lua"}

        -- Colorschemes
        use {'daschw/leaf.nvim'}

    end
})

return plugins
