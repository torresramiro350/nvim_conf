return {
	-- { "embark-theme/vim", as = "embark", priority = 1000 },
	{ "rebelot/kanagawa.nvim" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- event = "VeryLazy",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				term_colors = false,
				rainbow_delimiters = true,
				integrations = {
					notify = "true",
				},
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				term_colors = true,
				transparent = false,
				style = "warm",
				lualine = {
					transparent = false,
				},
				code_style = {
					comments = "italic",
					keywords = "italic",
					functions = "none",
					variables = "none",
				},
				-- style = "warmer",
			})
		end,
	},
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				styles = {
					comment = { italic = true },
					keyword = { italic = true },
				},
				-- filter = "pro",
				filter = "spectrum",
				-- filter = "ristretto",
				-- filter = "machine",
				-- filter = "octagon",
				background_clear = {
					"float_win",
					"telescope",
					"notify",
					"bufferline",
				},
			})
		end,
		lazy = true,
	},
	-- {
	--   "NTBBloodbath/doom-one.nvim",
	--   priority = 1000,
	--   lazy = true,
	-- },
}
