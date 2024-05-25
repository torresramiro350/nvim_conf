return {
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",
	-- See `:help ibl`
	event = { "BufReadPre", "BufReadPost", "BufNewFile" },
	main = "ibl",
	config = function()
		local mocha_palette = require("catppuccin.palettes").get_palette("mocha")
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = mocha_palette.red })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = mocha_palette.yellow })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = mocha_palette.blue })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = mocha_palette.peach })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = mocha_palette.green })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = mocha_palette.mauve })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = mocha_palette.teal })
		end)
		-- vim.g.rainbow_delimiters = { highlight = highlight }
		-- require("ibl").setup({ scope = { highlight = highlight } })
		-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_etmark)

		require("ibl").setup({
			indent = { highlight = highlight },
		})
	end,
}
