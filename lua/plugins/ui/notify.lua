return {
	-- event = "UIEnter",
	"rcarriga/nvim-notify",
	-- event = { "BufReadPre", "BufNewFile" },
	lazy = false,
	priority = 1000,
	config = function()
		vim.notify = require("notify")
		local notify = require("notify")
		notify.setup({
			timeout = 2000,
			-- render = "compact",
			render = "wrapped-compact",
			stages = "fade",
		})
	end,
}
