return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		local noice = require("noice")

		noice.setup({
			lsp = {
				override = {
					["cmp.entry.get_documentation"] = true,
				},
				presets = {
					lsp_doc_border = true,
				},
			},
		})
		vim.keymap.set("c", "<S-Enter>", function()
			noice.redirective(vim.fn.getcmdline())
		end, { desc = "Redirect cmdline" })
	end,

	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
}
