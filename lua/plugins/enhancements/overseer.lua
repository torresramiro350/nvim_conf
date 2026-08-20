return {
	"stevearc/overseer.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
		{ "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
		{ "<leader>oc", "<cmd>OverseerClose<cr>", desc = "Toggle task list" },
		{ "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
		{
			"<leader>oR",
			function()
				local overseer = require("overseer")
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify("No tasks found", vim.log.levels.WARN)
				else
					overseer.run_action(tasks[1], "restart")
				end
			end,
			desc = "Restart last task",
		},
	},
	opts = {
		templates = { "builtin" },
	},
	config = function(_, opts)
		require("overseer").setup(opts)
	end,
}
