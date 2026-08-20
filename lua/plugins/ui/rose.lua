return {
	"rose-pine/neovim",
	name = "rose-pine",
	opts = {
		variant = "auto",
		dark_variant = "main",
		highlight_groups = {
			CurSearch = { fg = "base", bg = "leaf", inherit = false },
			Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
		},
		styles = {
			bold = true,
			italic = true,
			transparency = false,
		},
	},
	config = function(opts)
		require("rose-pine").setup(opts)
		vim.cmd("colorscheme rose-pine")
	end,
}
