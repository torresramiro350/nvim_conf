return {
	"f-person/git-blame.nvim",
	lazy = true,
	event = "VeryLazy",
	cond = function()
		-- enable plugins only within a git repo
		local current_dir = vim.fn.getcwd()
		local git_dir = current_dir .. "/.git"
		return vim.fn.isdirectory(git_dir) == 1
	end,
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
