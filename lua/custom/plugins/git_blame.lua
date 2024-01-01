return {
	"f-person/git-blame.nvim",
	lazy = true,
	event = "VeryLazy",
	config = function()
		local git_blame = require("gitblame")
		require("lualine").setup({
			-- sections = {
			-- 	lualine_c = {
			-- 		{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
			-- 	},
			-- },
		})
	end,
}
