return {
	"freddiehaddad/feline.nvim",
	config = function(_, opts)
		-- SIMPLER SETUP
		local ctp_feline = require("catppuccin.groups.integrations.feline")

		ctp_feline.setup({
			-- inactive = {
			-- 	"file_info",
			-- },
			--- default setup
			-- if no options are passed, then the defaults are kept
			assets = {
				left_separator = "",
				right_separator = "",
				dir = "󰉖",
				file = "󰈙",
				lsp = {
					server = "󰅡 ",
					error = " ",
					warning = " ",
					info = " ",
					hint = " ",
				},
				git = {
					branch = "",
					added = " ",
					changed = " ",
					removed = " ",
				},
			},
		})

		require("feline").setup({
			components = ctp_feline.get(),
		})
	end,
	priority = 1000,
	event = "UIEnter",
}
