-- Bufferline
return {
	"akinsho/bufferline.nvim",
	-- lazy = true,
	event = { "BufReadPost" },
	config = function()
		-- vim.opt.termguicolors = true
		vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Close current buffer" })
		vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
		vim.keymap.set("n", "<s-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })
		-- vim.keymap.set("n", "[f", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
		-- vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })
		vim.keymap.set("n", "<leader>ba", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close all other buffers" })
		vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close next tab" })
		vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close previous tab" })
		vim.keymap.set("n", "<leader>bq", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Close group" })
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {

				-- style_preset = bufferline.style_preset.no_bold,
				separator_style = "slant",
				-- indicator = { style = "underline" },
				diagnostics = "nvim_lsp",
				hover = {
					enabled = true,
					delayed = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "NvimTree",
						-- filetype = "Neo-tree",
						-- text = "File Explorer",
						text = function()
							return vim.fn.getcwd()
						end,
						highlight = "Directory",
						separator = true,
						text_align = "center",
					},
				},
			},
		})
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
