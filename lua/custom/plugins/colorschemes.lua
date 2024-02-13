return {

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local cat = require("catppuccin")

			-- local mocha = require("catppuccin.palettes").get_palette("mocha")

			cat.setup({
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = { "italic" },
					functions = {},
					keywords = { "italic" },
					types = { "italic" },
					-- strings = {},
					-- variables = {},
					-- numbers = {},
					-- booleans = {},
					-- properties = {},
					-- operators = {},
				},
				integrations = {
					--defaults
					notify = true,
					telescope = true,
				},
				highlight_overrides = {
					mocha = function(mocha)
						-- return { LineNr = { fg = mocha.lavender } }
						return { LineNr = { fg = mocha.overlay0 } }
					end,
				},
			})
		end,
	},
	{
		"marko-cerovac/material.nvim",
		priority = 1000,
		lazy = true,
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
