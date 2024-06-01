return {
	"danymat/neogen",
	config = function()
		-- adding some keybindings
		local nmap = function(mode, keys, func, additional_args)
			additional_args = additional_args or {}
			vim.keymap.set(mode, keys, func, additional_args)
		end
		-- Neogen keymaps
		-- leaving the keymappings here, otherwise the plugin is loaded
		-- unnecessarily at startup
		local neogen = require("neogen")
		nmap("n", "<leader>nf", "<cmd>Neogen func<cr>", { desc = "Generate func docs", noremap = true, silent = true })
		nmap(
			"n",
			"<leader>nc",
			"<cmd>Neogen class<cr>",
			{ desc = "Generate class docs", noremap = true, silent = true }
		)
		nmap("n", "<leader>nF", "<cmd>Neogen class<cr>", { desc = "Generate file docs", noremap = true, silent = true })
		nmap("i", "<C-l>", neogen.jump_next, { desc = "Jump to next annotation", noremap = true, silent = true })
		nmap("i", "<C-h>", neogen.jump_prev, { desc = "Jump to previous annotation", noremap = true, silent = true })

		require("neogen").setup({
			-- snippet_engine = "luasnip",
			enabled = true,
			input_after_comment = true,
			languages = {
				lua = {
					template = {
						annotation_convention = "emmylua",
					},
				},
				python = {
					template = {
						annotation_convention = "reST",
						-- annotation_convention = "numpydoc",
					},
				},
				cpp = {
					template = {
						annotation_convention = "doxygen",
					},
				},
				rust = {
					template = {
						annotation_convention = "rustdoc",
					},
				},
				sh = {
					template = {
						annotation_convention = "google_bash",
					},
				},
			},
		})
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = { "BufReadPost", "InsertEnter" },
}
