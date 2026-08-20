return {
	"jeangiraldoo/codedocs.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"<leader>cn",
			function()
				require("codedocs").generate()
			end,
		},
	},
	opts = {
		languages = {
			python = {
				filetypes = { "python" },
				default_style = "reST",
			},
			cpp = {
				default_style = "Doxygen",
			},
			lua = {
				default_style = "EmmyLua",
			},
			bash = {
				filetypes = { "sh", "bash" },
				default_style = "Google",
			},
		},
	},
	config = function(_, opts)
		require("codedocs").setup(opts)
	end,
}
