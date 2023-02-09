-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/mvaldez/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/mvaldez/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/mvaldez/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/mvaldez/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/mvaldez/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["codi.vim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/codi.vim",
    url = "https://github.com/metakirby5/codi.vim"
  },
  ["dressing.nvim"] = {
    config = { 'require("config.dressing")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["everforest-nvim"] = {
    config = { 'require("config.everforest")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/everforest-nvim",
    url = "https://github.com/neanias/everforest-nvim"
  },
  ["gitsigns.nvim"] = {
    config = { 'require("config.gitsigns")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/glow.nvim",
    url = "https://github.com/ellisonleao/glow.nvim"
  },
  ["gopher.nvim"] = {
    config = { 'require("config.gopher")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/gopher.nvim",
    url = "https://github.com/olexsmir/gopher.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { 'require("config.indent-blankline")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["kotlin-vim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/kotlin-vim",
    url = "https://github.com/udalov/kotlin-vim"
  },
  ["leaf.nvim"] = {
    config = { 'require("config.leaf")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/leaf.nvim",
    url = "https://github.com/daschw/leaf.nvim"
  },
  ["leap.nvim"] = {
    config = { 'require("config.leap")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { 'require("config.lualine")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-tool-installer.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    config = { 'require("config.mason")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  melange = {
    config = { 'require("config.melange")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/melange",
    url = "https://github.com/savq/melange"
  },
  ["neoconf.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/neoconf.nvim",
    url = "https://github.com/folke/neoconf.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { 'require("config.neoscroll")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  neotest = {
    config = { 'require("config.neotest")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/nvim-neotest/neotest"
  },
  ["neotest-go"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/neotest-go",
    url = "https://github.com/nvim-neotest/neotest-go"
  },
  ["neotest-python"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/neotest-python",
    url = "https://github.com/nvim-neotest/neotest-python"
  },
  ["neotest-rust"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/neotest-rust",
    url = "https://github.com/rouge8/neotest-rust"
  },
  ["nightfox.nvim"] = {
    config = { 'require("config.nightfox")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["noctis.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/noctis.nvim",
    url = "https://github.com/kartikp10/noctis.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { 'require("config.nvim-autopairs")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { 'require("config.nvim-cmp")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    config = { 'require("config.nvim-comment")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-comment",
    url = "https://github.com/terrortylor/nvim-comment"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    config = { 'require("config.lsp")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-surround"] = {
    config = { 'require("config.surround")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    config = { 'require("config.nvim-treesitter")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["symbols-outline.nvim"] = {
    config = { 'require("config.symbols-outline")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { 'require("config.telescope")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { 'require("config.trouble")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-kitty"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/vim-kitty",
    url = "https://github.com/fladson/vim-kitty"
  },
  ["vim-kitty-navigator"] = {
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/vim-kitty-navigator",
    url = "https://github.com/knubie/vim-kitty-navigator"
  },
  ["which-key.nvim"] = {
    config = { 'require("config.which-key")' },
    loaded = true,
    path = "/Users/mvaldez/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: gopher.nvim
time([[Config for gopher.nvim]], true)
require("config.gopher")
time([[Config for gopher.nvim]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
require("config.mason")
time([[Config for mason.nvim]], false)
-- Config for: melange
time([[Config for melange]], true)
require("config.melange")
time([[Config for melange]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require("config.nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require("config.indent-blankline")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require("config.nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
require("config.which-key")
time([[Config for which-key.nvim]], false)
-- Config for: leaf.nvim
time([[Config for leaf.nvim]], true)
require("config.leaf")
time([[Config for leaf.nvim]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
require("config.neoscroll")
time([[Config for neoscroll.nvim]], false)
-- Config for: nvim-comment
time([[Config for nvim-comment]], true)
require("config.nvim-comment")
time([[Config for nvim-comment]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
require("config.leap")
time([[Config for leap.nvim]], false)
-- Config for: neotest
time([[Config for neotest]], true)
require("config.neotest")
time([[Config for neotest]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
require("config.dressing")
time([[Config for dressing.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require("config.lsp")
time([[Config for nvim-lspconfig]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require("config.lualine")
time([[Config for lualine.nvim]], false)
-- Config for: everforest-nvim
time([[Config for everforest-nvim]], true)
require("config.everforest")
time([[Config for everforest-nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require("config.gitsigns")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
require("config.surround")
time([[Config for nvim-surround]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require("config.nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nightfox.nvim
time([[Config for nightfox.nvim]], true)
require("config.nightfox")
time([[Config for nightfox.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("config.telescope")
time([[Config for telescope.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
require("config.trouble")
time([[Config for trouble.nvim]], false)
-- Config for: symbols-outline.nvim
time([[Config for symbols-outline.nvim]], true)
require("config.symbols-outline")
time([[Config for symbols-outline.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
