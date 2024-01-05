return {
	{
		"maxmx03/dracula.nvim",
		priority = 1000,
		config = function()
			local dracula = require("dracula")
			dracula.setup({
				soft = false,
				-- soft = true,
				saturation = {
					enabled = false,
					amount = 0,
				},
				override = {
					["@keyword"] = { italic = true },
					["@parameter"] = { italic = true },
				},
				-- colors = {
				-- 	-- bgdark = "#1e1f29",
				-- 	bg = "#1e1f29",
				-- },
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		lazy = true,
		-- priority = 1000,
		config = function()
			require("onedark").setup({
				toggle_style_key = "<leader>ts",
				term_colors = true,
				-- transparent = {
				-- 	background = false,
				-- 	lualine = false,
				-- },
				-- style = "darker",
				-- style = "deep",
				style = "cool",
				-- style = "warm",
				code_style = {
					comments = "italic",
					keywords = "italic",
					strings = "italic",
					functions = "none",
					variables = "none",
				},
			})
		end,
	},
}
