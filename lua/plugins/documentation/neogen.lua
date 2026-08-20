return {
	"danymat/neogen",
	enabled = false,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = { "BufNewFile ", "BufReadPre" },
	cmd = "Neogen",
	keys = {
		{
			"<leader>cn",
			function()
				require("neogen").generate()
			end,
			desc = "Generate annotations (Neogen)",
		},
	},
	opts = {
		-- snippet_engine = "luasnip",
		snippet_engine = "mini",
		input_after_comment = true,
		languages = {
			lua = {
				template = {
					annotation_convention = "emmylua",
				},
			},
			python = {
				template = {
					annotation_convention = "reST",
					-- annotation_convention = "numpydoc",
				},
			},
			c = {
				template = {
					annotation_convention = "doxygen",
				},
			},
			cpp = {
				template = {
					annotation_convention = "doxygen",
				},
			},
			rust = {
				template = {
					annotation_convention = "rustdoc",
				},
			},
			sh = {
				template = {
					annotation_convention = "google_bash",
				},
			},
		},
	},
}
