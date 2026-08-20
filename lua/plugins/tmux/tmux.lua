return {
	event = "VeryLazy",
	enabled = false,
	-- event = "VimEnter",
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd> TmuxNavigateLeft<CR>" },
		{ "<c-j>", "<cmd> TmuxNavigateDown<CR>" },
		{ "<c-k>", "<cmd> TmuxNavigateUp<CR>" },
		{ "<c-l>", "<cmd> TmuxNavigateRight<CR>" },
		-- { "<c-\\>", "<cmd> TmuxNavigatePrevious<CR>" },
	},
}
