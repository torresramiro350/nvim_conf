-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					-- add mappings in insert mode
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
						["<C-j>"] = {
							actions.move_selection_next,
							type = "action",
						},
						["<C-k>"] = {
							actions.move_selection_previous,
							type = "action",
						},
					},
					-- add mappings in normal mode
					n = {
						["q"] = {
							actions.close,
							type = "action",
						},
						["j"] = {
							actions.move_selection_next,
							type = "action",
						},
						["k"] = {
							actions.move_selection_previous,
							type = "action",
						},
					},
				},
			},
		})
	end,
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
}
