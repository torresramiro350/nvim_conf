return {
	"numToStr/FTerm.nvim",
	config = function()
		local nmap = function(mode, keys, func, additional_args)
			additional_args = additional_args or {}
			vim.keymap.set(mode, keys, func, additional_args)
		end
		local fterm = require("FTerm")
		local lazygit = fterm:new({ ft = "fterm_gitui", cmd = "lazygit", dimensions = { width = 0.8, height = 0.8 } })
		local btm = fterm:new({ ft = "fterm_btm", cmd = "btm", dimensions = { width = 0.8, height = 0.8 } })
		fterm.setup({
			cmd = "/usr/bin/fish",
			border = "rounded",
			dimensions = {
				width = 0.8,
				height = 0.8,
			},
		})
		nmap(
			{ "n", "t" },
			"<A-enter>",
			'<c-\\><c-n><cmd>lua require("FTerm").toggle()<cr>',
			{ desc = "Toggle terminal" }
		)
		nmap("n", "<A-g>", function()
			lazygit:toggle()
		end, { desc = "Lazygit" })
		nmap("n", "<A-b>", function()
			btm:toggle()
		end, { desc = "Bottom monitor" })
	end,
	event = { "BufNewFile", "BufReadPre" },
}
