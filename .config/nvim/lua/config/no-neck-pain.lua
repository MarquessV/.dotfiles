require("no-neck-pain").setup({
	autocmds = {
		enableOnVimEnter = true,
		enableOnTabEnter = false,
	},
	disableOnLastBuffer = true,
	buffers = {
		colors = {
			blend = -0.10,
		},
		bo = {
			filetype = "no-neck-pain",
		},
		right = {
			enabled = false,
		},
		scratchPad = {
			enabled = false,
			fileName = "devlog",
		},
	},
})
