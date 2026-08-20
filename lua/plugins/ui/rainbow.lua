return {
	"HiPhish/rainbow-delimiters.nvim",
	enabled = true,
	event = { "BufRead" },
	opts = {},
	config = function(_, opts)
		require("rainbow-delimiters.setup").setup(opts)
	end,
}
