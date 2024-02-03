return {
	{
		"marko-cerovac/material.nvim",
		priority = 1000,
		config = function()
			require("material").setup({
				disable = {
					borders = false,
					colored_cursor = false,
					term_colors = false,
				},
				styles = {
					functions = { italic = true, bold = false },
					keywords = { italic = true, bold = true },
					types = { italic = true, bold = true },
					-- variables = { bold = true },
					operators = { bold = true },
				},
				high_visibility = {
					lighter = false,
					darker = true,
				},
				contrast = {
					borders = false,
					side_bars = false,
					terminal = false,
					cursor_line = true,
					floating_windows = false,
					non_current_window = true,
					filetypes = {
						--
					},
				},
				plugins = {
					"gitsigns",
					"nvim-tree",
					"nvim-navic",
					"nvim-web-devicons",
					"noice",
					"rainbow-delimiters",
					"flash",
					"telescope",
					"nvim-notify",
					"which-key",
					"trouble",
				},
				custom_highlights = {
					--
				},
				-- lualine_style = "default",
				lualine_style = "stealth",
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
