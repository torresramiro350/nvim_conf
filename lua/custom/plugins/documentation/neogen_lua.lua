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
		nmap("n", "<leader>nf", "<cmd>Neogen func<cr>", { desc = "Generate func docs" })
		nmap("n", "<leader>nc", "<cmd>Neogen class<cr>", { desc = "Generate class docs" })
		nmap("n", "<leader>nF", "<cmd>Neogen file<cr>", { desc = "Generate file docs" })
		nmap("i", "<C-l>", require("neogen").jump_next, { desc = "Jump to next annotation" })
		nmap("i", "<C-h>", require("neogen").jump_prev, { desc = "Jump to previous annotation" })
		require("neogen").setup({
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
						-- annotation_convention = "reST",
						annotation_convention = "numpydoc",
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
