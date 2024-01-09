return {
	"danymat/neogen",
	config = function()
		-- adding some keybindings
		-- local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>nf", "<cmd>Neogen func<cr>", { desc = "Generate func docs " })
		vim.keymap.set("n", "<leader>nc", "<cmd>Neogen class<cr>", { desc = "Generate class docs " })
		vim.keymap.set("n", "<leader>nF", "<cmd>Neogen file<cr>", { desc = "Generate file docs " })

		-- map("n", "<leader>1", ":lua require('neogen').generate({type = 'func' })<CR>", opts)
		-- map("n", "<leader>2", ":lua require('neogen').generate({type = 'class' })<CR>", opts)
		-- map("n", "<leader>3", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)

		require("neogen").setup({
			-- snippet_engine = "luasnip",
			-- snippet_engine = "vsnip",
			-- snippet_engine = "snippy",
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
						-- annotation_convention = "google_docstrings",
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
	-- event = { "BufReadPost", "BufNewFile" },
}
