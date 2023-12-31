return {
	"HiPhish/rainbow-delimiters.nvim",
	config = function()
		require("rainbow-delimiters.setup").setup({
			-- call options here
		})
	end,
	-- priority = 1000,
	-- when starting to edit a new buffer
	event = { "BufReadPre" },
}
