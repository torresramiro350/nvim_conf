return {
	{
		"echasnovski/mini.comment",
		version = false,
		-- event = "VeryLazy",
		-- event = { "BufEnter" },
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local ts_context = require("ts_context_commentstring.internal")
			return {
				mappings = {
					comment = "gc",
					comment_line = "gcc",
					comment_visual = "gc",
					textobject = "gc",
				},
				options = {
					custom_commentstring = function()
						return ts_context.calculate_commentstring() or vim.bo.commentstring
					end,
				},
			}
		end,
		config = function(_, opts)
			local minicomment = require("mini.comment")
			-- mini.comment
			minicomment.setup(opts)
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_cmd = false,
		},
	},
}
