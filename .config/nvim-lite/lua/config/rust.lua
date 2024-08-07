return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							procMacro = {
								ignored = {
									leptos_macro = {
										-- optional: --
										-- "component",
										"server",
									},
								},
							},
							cargo = {
								allFeatures = true,
							},
						},
					},
				},
			}
		end,
	},
	{
		"Saecki/crates.nvim",
		tag = "v0.4.0",
		ft = { "rust", "toml" },
		config = function()
			require("crates").setup()
		end,
	},
}
