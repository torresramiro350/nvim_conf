return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
	-- config = true,
	config = function()
		local neogit = require("neogit")
		neogit.setup({})
	end,
	event = { "BufReadPost" },
	cond = function()
		-- enable plugins only within a git repo
		local current_dir = vim.fn.getcwd()
		local git_dir = current_dir .. "/.git"
		return vim.fn.isdirectory(git_dir) == 1
	end,
}
