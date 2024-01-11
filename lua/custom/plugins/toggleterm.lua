return {
	"numToStr/FTerm.nvim",
	config = function()
		local fterm = require("FTerm")
		fterm.setup({
			border = "single",
			dimensions = {
				width = 0.8,
				height = 0.8,
			},
		})
		vim.keymap.set("n", "<A-i>", "<cmd>lua require('FTerm').toggle()<cr>", { desc = "Toggle terminal" })
		vim.keymap.set("t", "<A-i>", '<c-\\><c-n><cmd>lua require("FTerm").toggle()<cr>', { desc = "Toggle terminal" })
		vim.keymap.set("n", "<leader>lt", "<cmd>lua require('FTerm').run('lazygit')<cr>", { desc = "Lazygit" })
	end,
	event = "VeryLazy",
}
