return {
	"lmilojevicc/herdr-splits.nvim",
	event = "VeryLazy",
	cond = vim.env.HERDR_ENV == "1",
	keys = {
    -- stylua: ignore start
		{ "<C-h>", function() require("herdr-splits").move_cursor_left() end, desc = "Navigate left" },
		{ "<C-l>", function() require("herdr-splits").move_cursor_right() end, desc = "Navigate right" },
		{ "<C-j>", function() require("herdr-splits").move_cursor_down() end, desc = "Navigate down" },
		{ "<C-k>", function() require("herdr-splits").move_cursor_up() end, desc = "Navigate up" },
		{ "M-h", function() require("herdr-splits").resize_left() end, desc = "Resize left" },
		{ "M-l", function() require("herdr-splits").resize_right() end, desc = "Resize right" },
		{ "M-j", function() require("herdr-splits").resize_down() end, desc = "Resize down" },
		{ "M-k", function() require("herdr-splits").resize_up() end, desc = "Resize up" },
		-- stylua: ignore end
	},
	opts = {
		default_amount = 0.03,
		neovim_amount = 0.3,
		at_edge = "wrap",
		ignored_buftypes = { "nofile", "quickfix", "prompt", "help", "terminal" },
		ignored_filetypes = {
			"neo-tree",
			-- "snacks_dashboard",
			"snacks_explorer",
			"snacks_picker",
			"dadbod-ui",
			"dbout",
			"aerial",
			"Outline",
			"Trouble",
			"quickfix",
		},
	},
	config = function(_, opts)
		require("herdr-splits").setup(opts)
	end,
}
