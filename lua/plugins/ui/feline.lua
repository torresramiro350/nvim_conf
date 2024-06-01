return {
	"freddiehaddad/feline.nvim",
	enabled = true,
	-- event = "UIEnter",
	event = "ColorSchemePre",
	config = function()
		local ctp_feline = require("catppuccin.groups.integrations.feline")

		ctp_feline.setup({
			--- default setup
			inactive = {
				-- "file_info",
			},
			view = {
				lsp = {
					progress = true,
					name = true,
					separator = "  ",
					exclude_lsp_names = { "null-ls" },
				},
			},
		})

		require("feline").setup({
			components = ctp_feline.get(),
		})

		-- require("feline").setup({})
		-- require("feline").winbar.setup() -- to use winbar
		-- require("feline").statuscolumn.setup() -- to use statuscolumn
	end,
}
