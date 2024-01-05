return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		local barbecue = require("barbecue")
		barbecue.setup({
			-- add options here
		})
	end,
	-- lazy loading to prevent slowdown
	-- load when buffer has been loaded for reading
	event = { "BufEnter", "BufRead", "BufReadPost" },
}
