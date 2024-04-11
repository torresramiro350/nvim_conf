return {
	"freddiehaddad/feline.nvim",
	config = function(_, opts)
		-- SIMPLER SETUP
		local ctp_feline = require("catppuccin.groups.integrations.feline")

		ctp_feline.setup({
			--- default setup
			-- inactive = {
			-- 	"file_info",
			-- },
			view = {
				lsp = {
					progress = true,
					name = true,
					separator = "|",
					exclude_lsp_names = { "null-ls", "copilot" },
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
