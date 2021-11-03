---- ALIASES ----
-- local cmd = vim.cmd 	-- vim commands
-- local fn = vim.fn 	-- vim functions
local g = vim.g -- global let options
local o = vim.o -- global options

---- PREPLUGIN ----
g.tokyonight_style = 'night'

---- PLUGINS ----
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Colorscheme --
    use 'shaunsingh/nord.nvim'
    use {
        'rmehri01/onenord.nvim',
        config = function() require('onenord').setup() end
    }
    use 'folke/tokyonight.nvim'
    use {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup({default = true})
        end
    }

    -- QoL --
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-sleuth'
    use {
        'sunjon/shade.nvim',
        config = function()
            require('shade').setup({overlay_opacity = 60})
        end
    }
    use "fladson/vim-kitty"
    use {"romgrk/barbar.nvim", requires = {'kyazdani42/nvim-web-devicons'}}
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                char = "|",
                buftype_exclude = {"terminal"}
            }
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    use {
        'phaazon/hop.nvim',
        as = 'hop',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
        end
    }
    use {
        'karb94/neoscroll.nvim',
        config = function() require('neoscroll').setup() end
    }
    -- use 'wfxr/minimap.vim' -- I like this but it's buggy atm
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
                ts_config = {
                    lua = {'string'}, -- it will not add a pair on that treesitter node
                    javascript = {'template_string'}
                }
            })
        end
    }

    -- Statusline - lualine --
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'onenord',
                    lualine_b = {
                        'branch', 'diff',
                        {'diagnostics', sources = {'nvim_lsp'}}
                    },
                    lualine_c = {'filename', 'buffers'}
                }
            })
        end
    }
    use {
        'edluffy/specs.nvim',
        config = function()
            require('specs').setup {
                show_jumps = true,
                min_jump = 30,
                popup = {
                    delay_ms = 0,
                    inc_ms = 20,
                    blend = 0,
                    width = 20,
                    winhl = "PMenu",
                    fader = require('specs').pulse_fader,
                    resizer = require('specs').shrink_resizer
                },
                ignore_filetypes = {},
                ignore_buftypes = {nofile = true}
            }
        end
    }

    -- Markdown --
    use 'ellisonleao/glow.nvim'

    -- Dev tools --
    use 'leafOfTree/vim-matchtag'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        tag = 'release',
        config = function()
            require('gitsigns').setup({
                current_line_blame = true,
                current_line_blame_formatter_opts = {relative_time = true}
            })
        end
    }
    use {'pwntester/octo.nvim', config = function() require"octo".setup() end}
    use 'vim-test/vim-test'

    -- LSP --
    -- Easier config and managed install of providers
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                refactor = {
                    highlight_definitions = {enable = true},
                    smart_rename = {
                        enable = true,
                        keymaps = {smart_rename = "grr"}
                    }
                },
                highlight = {
                    enable = true -- false will disable the whole extension
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = 'gnn',
                        node_incremental = 'grn',
                        scope_incremental = 'grc',
                        node_decremental = 'grm'
                    }
                },
                indent = {enable = true},
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer'
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer'
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer'
                        }
                    }
                }
            })
        end
    }
    use {'nvim-treesitter/nvim-treesitter-refactor', run = ':TSUpdate'}
    use {
        'romgrk/nvim-treesitter-context',
        config = function()
            require'treesitter-context'.setup {
                enable = true,
                throttle = true,
                max_lines = 0,
                patterns = {
                    default = {
                        'class', 'function', 'method'
                        -- 'for', -- These won't appear in the context
                        -- 'while',
                        -- 'if',
                        -- 'switch',
                        -- 'case',
                    }
                }
            }
        end
    }
    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end
    }

    -- Completion engine with sources
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'ray-x/cmp-treesitter'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-nvim-lua'
    -- Utility for better symbols and colors in lsp autocomplete menu
    use 'onsails/lspkind-nvim'

    -- Fuzzyfinder - Telescope
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup {
                defaults = {
                    mappings = {i = {['<C-u>'] = false, ['<C-d>'] = false}}
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case"
                    }
                }
            }
            require('telescope').load_extension('fzf')
        end
    }
    use 'nvim-lua/plenary.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- Snippets - vsnip
    use 'hrsh7th/vim-vsnip'

    -- Utilities
    use {
        'sam-sjs/vim-kitty-navigator',
        run = 'cp ./*.py ~/.config/kitty/',
        branch = 'Issue#20'
    }
end)

---- PLUGIN CONFIGS ----
-- MatchTag --
g.vim_matchtag_files = '*.html,*.xml,*.js,*.jsx,*.vue,*.svelte,*.jsp'
g.vim_matchtag_highlight_cursor_on = 1
-- Minimap --
g.minimap_width = 10
g.minimap_auto_start = 1
g.minimap_auto_start_win_enter = 1
g.minimap_highlight_range = 1
g.minimap_git_colors = 1
g.minimap_highlight_search = 1
-- Vim Test --
g['test#strategy'] = "neovim"

---- LSP ----
local lsp = vim.lsp
local handlers = lsp.handlers
local pop_opts = {border = "rounded", max_width = 80}
handlers["textDocument/hover"] = lsp.with(handlers.hover, pop_opts)
handlers["textDocument/signature_help"] =
    lsp.with(handlers.signature_help, pop_opts)

local lsp_installer = require("nvim-lsp-installer")

-- Autoformatting using the lsp
vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.formatting_sync()]]

-- Autogroup for Markdown previews
vim.cmd [[autocmd FileType markdown noremap <leader>p :Glow<CR>]]

-- Setup nvim-cmp.
local cmp = require 'cmp'
local lspkind = require "lspkind"
lspkind.init()

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

cmp.setup({
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {"i", "s"})
    },
    sources = {
        {name = 'nvim_lsp'}, {name = 'vsnip'},
        {name = 'treesitter', keyword_length = 3}, {name = 'nvim_lua'},
        {name = 'path'}, {name = 'buffer', keyword_length = 5}
    },
    experimental = {native_menu = false, ghost_text = true},
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                treesitter = "[tree]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]"
            }
        }
    }
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    buf_set_keymap('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'ca', '<cmd>Telescope code_actions<CR>', opts)
    buf_set_keymap('n', '<leader>e',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics(popup_opts={focusable=false, border="rounded"})<CR>',
                   opts)
    buf_set_keymap('n', '[d',
                   "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts={focusable=false,border='rounded'}})<CR>",
                   opts)
    buf_set_keymap('n', ']d',
                   '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts={focusable=false,border="rounded"}})<CR>',
                   opts)
    buf_set_keymap('n', '<leader>t', '<cmd>Telescope lsp_document_symbols<CR>',
                   opts)
    buf_set_keymap('n', '<leader>d',
                   '<cmd>Telescope lsp_document_diagnostics<CR>', opts)
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150}
    }

    if server.name == "efm" then
        opts = {
            cmd = {"efm-langserver"},
            init_options = {documentFormatting = true},
            filetypes = {
                "javascript", "javascript.jsx", "javascriptreact", "lua",
                "python"
            },
            settings = {
                languages = {
                    lua = {
                        {formatCommand = "lua-format -i", formatStdin = true}
                    },
                    javascript = {
                        {
                            formatCommand = "prettier-eslint --stdin --parser babel",
                            formatStdin = true
                        }
                    },
                    python = {
                        {formatCommand = "black --quiet -", formatStdin = true}
                    }
                }
            }
        }
    end

    if server.name == "tsserver" then
        -- disable tsserver formatter so it automatically chooses emf
        local default_on_attach = opts.on_attach
        opts.on_attach = function(client, bufnr)
            default_on_attach(client, bufnr)
            client.resolved_capabilities.document_formatting = false
        end
    end

    if server.name == "sumneko_lua" then
        opts.settings = {Lua = {diagnostics = {globals = {'vim'}}}}
    end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

---- VIM OPTIONS ----
-- Colorscheme --
vim.cmd [[colorscheme onenord]]

-- nord setup --
-- vim.cmd [[colorscheme nord]]
-- g.nord_borders = true
-- g.nord_italic = true
-- g.nord_contrast = true
-- require('nord').set()

-- Global --
o.hidden = true
o.number = true
o.showmatch = true
o.cursorline = true
o.signcolumn = "number"
o.completeopt = "menu,menuone,noselect"
o.mouse = "a"
g.mapleader = ","

-- Folds --
o.foldlevel = 20
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Better searching --
o.hlsearch = true
o.smartcase = true
o.ignorecase = true

-- Whitespace settings --
o.autoindent = true
o.smartindent = true
-- o.expandtab = true
-- o.shiftwidth = 4
-- o.softtabstop = 4
o.title = true

-- Splits --
o.splitbelow = true
o.splitright = true

---- MAPPINGS ----
-- map helper
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local silent_noremap = {noremap = true, silent = true}

-- Quickly clear highlights
map('n', '<leader><space>', ':nohlsearch<CR>')

-- Y behaves more like D and C
map('n', 'Y', 'y$')

-- Quickly edit and source vimrc
map('n', '<leader>ev', ':vsp ~/.config/nvim/init.lua<cr>')
map('n', '<leader>sv', ':source ~/.config/nvim/init.lua | PackerSync<cr>')

-- Keep text centered when jumping
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- Move text
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
-- map('i', '<C-j>', '<esc>:m .+1<CR>==<<CR>i')
-- map('i', '<C-k>', '<esc>:m .-2<CR>==<<CR>i')
map('n', '<leader>k', ':m .-2<CR>==')
map('n', '<leader>j', ':m .+1<CR>==')

-- Telescope
map('n', '<C-p>', '<cmd> Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd> Telescope live_grep<cr>')
map('n', '<leader>b', '<cmd> Telescope buffers<cr>')
map('n', '<leader>fb', '<cmd> Telescope file_browser<cr>')
map('n', '<leader>fh', '<cmd> Telescope help_tags<cr>')
map('n', '<leader>gs', '<cmd> Telescope git_status<cr>')
map('n', '<leader>gc', '<cmd> Telescope git_commits<cr>')
map('n', '<leader>ts', '<cmd> Telescope treesitter<cr>')
map('n', '<leader>pr', '<cmd> Octo pr list<cr>')

-- Toggle fold with space
map('n', '<space>', [[@=(foldlevel('.')?'za':"\<Space>")<CR>]], silent_noremap)
map('v', '<space>', 'zf')

-- tabbar - barbar
-- Move to previous/next (alt-, alt-.)
map('n', '≤', ':BufferPrevious<CR>', silent_noremap)
map('n', '≥', ':BufferNext<CR>', silent_noremap)
-- Goto buffer in position... (alt-1, ..., alt-0)
map('n', '¡', ':BufferGoto 1<CR>', silent_noremap)
map('n', '™', ':BufferGoto 2<CR>', silent_noremap)
map('n', '£', ':BufferGoto 3<CR>', silent_noremap)
map('n', '¢', ':BufferGoto 4<CR>', silent_noremap)
map('n', '∞', ':BufferGoto 5<CR>', silent_noremap)
map('n', '§', ':BufferGoto 6<CR>', silent_noremap)
map('n', '¶', ':BufferGoto 7<CR>', silent_noremap)
map('n', '•', ':BufferGoto 8<CR>', silent_noremap)
map('n', 'ª', ':BufferGoto 9<CR>', silent_noremap)
map('n', 'º', ':BufferLast<CR>', silent_noremap)
-- Close buffer
map('n', 'ç', ':BufferClose<CR>', silent_noremap)
-- Sort automatically by...
map('n', '<leader>bb', ':BufferOrderByBufferNumber<CR>', silent_noremap)
map('n', '<leader>bd', ':BufferOrderByDirectory<CR>', silent_noremap)
map('n', '<leader>bl', ':BufferOrderByLanguage<CR>', silent_noremap)

-- Hop
map('n', '$', "<cmd>lua require'hop'.hint_words()<cr>")
map('n', 'z', "<cmd>:HopChar1<cr>")

-- Vim Test
map("n", "<leader>tn", "<cmd>:TestNearest<CR>", silent_noremap)
map("n", "<leader>tf", "<cmd>:TestFile<CR>", silent_noremap)
map("n", "<leader>ts", "<cmd>:TestSuite<CR>", silent_noremap)
map("n", "<leader>tl", "<cmd>:TestLast<CR>", silent_noremap)
map("n", "<leader>tv", "<cmd>:TestVisit<CR>", silent_noremap)

local function file_exists(fname)
    local stat = vim.loop.fs_stat(fname)
    return (stat and stat.type) or false
end

-- Alternate File
function AlternateFile()
    local current_file = vim.fn.expand('%')
    local command = 'alt ' .. current_file
    local alternate_file = io.popen(command):read('*all')
    if file_exists(alternate_file) then
        vim.api.nvim_command('edit ' .. alternate_file)
    else
        print('no alternate file found')
    end
end

map("n", "<leader>a", "<cmd>lua AlternateFile()<CR>")
