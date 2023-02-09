require("everforest").setup({
	-- Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
	-- Default is "medium".
	background = "hard",
	-- How much of the background should be transparent. Options are 0, 1 or 2.
	-- Default is 0.
	--
	-- 2 will have more UI components be transparent (e.g. status line
	-- background).
	transparent_background_level = 1,
})

-- This theme needs to load _after_ the above configuration options for them to work.
if Config.theme == "everforest" then
	vim.cmd.colorscheme(Config.theme)
end
