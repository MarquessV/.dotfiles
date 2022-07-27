local theme_highlights = {}

if Config.theme == "leaf" then
	local background_color = {
		guibg = {
			attribute = "bg",
			highlight = "StatusLineNC"
		}
	}
	theme_highlights = {
		fill = background_color,
		separator = background_color,
		separator_selected = background_color,
		separator_visible = background_color
	}
end

require("bufferline").setup {
	options = {
		offsets = {
			filetype = "fern",
			text = "File Explorer",
			text_align = "center"
		},
		diagnostics = "nvim_lsp",
		color_icons = true,
		separator_style = "thin",
		themable = true,
		show_close_icon = false,
		show_buffer_close_icons = false,
		diagnostics_indicator = function(count, level, _, _)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		enforce_regular_tabs = true
	},
	highlights = theme_highlights,
}
