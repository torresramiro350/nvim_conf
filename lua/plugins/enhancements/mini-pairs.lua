return {
	"echasnovski/mini.pairs",
	version = false,
	event = "VeryLazy",
	opts = {
		modes = { insert = true, command = true, terminal = false },
		skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
		skip_ts = { "string" },
		skip_unbalanced = true,
		markdown = true,
	},
	config = function(_, opts)
		-- pairs
		require("mini.pairs").setup({ opts })
	end,
}
