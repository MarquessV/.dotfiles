-- Large movements re-center cursor
local mini_animate = require("mini.animate")

mini_animate.setup()

local animate_after = function(input, command)
	local pre_command = function()
		vim.cmd("normal! " .. input)
	end
	if string.sub(input, 1, 2) == "<c" then
		pre_command = function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(input, true, false, true), "n", true)
		end
	end
	return function()
		pre_command()
		mini_animate.execute_after("scroll", "normal! " .. command)
	end
end
vim.keymap.set("n", "n", animate_after("n", "zz"))
vim.keymap.set("n", "N", animate_after("N", "zz"))
vim.keymap.set("n", "<c-d>", animate_after("<c-d>", "zz"))
vim.keymap.set("n", "<c-u>", animate_after("<c-u>", "zz"))
