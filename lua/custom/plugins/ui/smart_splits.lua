return {
	"mrjones2014/smart-splits.nvim",
	version = ">1.0.0",
	build = "./kitty/install-kittens.bash",
	config = function()
		local smart_splits = require("smart-splits")
		smart_splits.setup({
			at_edge = "wrap",
		})
	end,
	event = { "BufReadPre" },
}
