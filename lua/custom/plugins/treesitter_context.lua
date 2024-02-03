return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup({
			enable = true,
			max_lines = 2,
			multiline_threshold = 3,
		})
	end,
	-- event = "VeryLazy",
	event = { "BufRead", "BufReadPost" },
}
