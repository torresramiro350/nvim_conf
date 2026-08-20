return {
	"OXY2DEV/markview.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"saghen/blink.cmp",
	},
	ft = { "markdown", "norg", "rmd", "org", "codecompanion", "blink-cmp-documentation", "blink-cmp-signature" },
	lazy = false,
	priority = 49,
	enabled = true,
	keys = {
		{ "<leader>cp", "<cmd>Markview toggle<cr>", desc = "Toggle markdown preview" },
	},
	opts = {
		preview = {
			enable = true,
			enable_hybrid_mode = true,
			filetypes = { "markdown", "quarto", "rmd", "typst" },
			ignore_buftypes = { "nofile" },
			icon_provider = "mini",
			debounce = 50,
		},
		markdown = {
			enable = true,
			headings = { enable = true, shift_width = 1 },
			code_blocks = { enable = true, style = "language", min_width = 60, pad_amount = 2 },
			block_quotes = { enable = true, default = { border = "▋" } },
		},
		list_items = { enable = true, marker_minus = { text = "•" } },
		checkboxes = {
			enable = true,
			checked = { text = "✔" },
			unchecked = { text = "✘" },
		},
		tables = { enable = true, style = "rounded" },
		markdown_inline = {
			enable = true,
			inline_codes = { enable = true },
			link = { enable = true },
		},
		html = { enable = true },
		latex = { enable = true },
		yaml = { enable = true },
	},
	config = function(_, opts)
		require("markview").setup(opts)
	end,
}
