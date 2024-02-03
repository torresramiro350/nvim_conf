return {
	"pwntester/octo.nvim",
	event = { "BufRead", "BufReadPost" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local octo = require("octo")
		octo.setup({
			picker = "telescope",
			picker_config = {
				checkout_pr = { lhs = "<C-o>", desc = "Checkout pull request" },
				merge_pr = { lhs = "<C-r>", desc = "Merge pull request" },
			},
		})
		-- PR
		vim.keymap.set("n", "<leader>pa", "<cmd>Octo pr create<cr>", { desc = "Create PR" })
		vim.keymap.set("n", "<leader>pl", "<cmd>Octo pr list<cr>", { desc = "PRs list" })
		vim.keymap.set("n", "<leader>po", "<cmd>Octo pr checkout<cr>", { desc = "Checkout PR" })
		vim.keymap.set("n", "<leader>pd", "<cmd>Octo pr diff<cr>", { desc = "Show PR diff" })
		vim.keymap.set("n", "<leader>pc", "<cmd>Octo pr commits<cr>", { desc = "List PR commits" })
		vim.keymap.set("n", "<leader>pf", "<cmd>Octo pr changes<cr>", { desc = "List PR files" })
		vim.keymap.set("n", "<leader>pm", "<cmd>Octo pr merge<cr>", { desc = "Merge PR" })
		-- Issues
		vim.keymap.set("n", "<leader>il", "<cmd>Octo issue list<cr>", { desc = "List issues" })
		vim.keymap.set("n", "<leader>io", "<cmd>Octo issue create<cr>", { desc = "Create issue" })
		vim.keymap.set("n", "<leader>ic", "<cmd>Octo issue close<cr>", { desc = "Close issue" })
		vim.keymap.set("n", "<leader>ib", "<cmd>Octo issue browser<cr>", { desc = "Open issue in browser" })
		vim.keymap.set("n", "<leader>ca", "<cmd>Octo comment add<cr>", { desc = "Add comment" })
	end,
	-- event = "VeryLazy",
	cond = function()
		-- enable plugins only within a git repo
		local current_dir = vim.fn.getcwd()
		local git_dir = current_dir .. "/.git"
		return vim.fn.isdirectory(git_dir) == 1
	end,
}
