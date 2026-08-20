return {
	"folke/flash.nvim",
	event = "VeryLazy",
	specs = {
		{
			"folke/snacks.nvim",
			opts = {
				picker = {
					win = {
						input = {
							keys = {
								["<a-s>"] = { "flash", mode = { "n", "i" } },
								["s"] = { "flash" },
							},
						},
					},
					actions = {
						flash = function(picker)
							require("flash").jump({
								pattern = "^",
								label = { after = { 0, 0 } },
								search = {
									mode = "search",
									exclude = {
										function(win)
											return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
												~= "snacks_picker_list"
										end,
									},
								},
								action = function(match)
									local idx = picker.list:row2idx(match.pos[1])
									picker.list:_move(idx, true, true)
								end,
							})
						end,
					},
				},
			},
		},
	},
	opts = {
		modes = {
			char = {
				jump_labels = true,
			},
			search = {
				enabled = true,
				highlight = { backdrop = true },
				jump = { history = true, register = true, nohlsearch = true },
			},
		},
		label = {
			uppercase = true,
			rainbow = {
				enabled = false,
				-- shade = 2,
				shade = 3,
			},
		},
	},
	keys = {
    -- stylua: ignore start
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r",     mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R",     mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		-- stylua: ignore end
		{
			"<leader>cD",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					matcher = function(win)
						return vim.tbl_map(function(diag)
							return {
								pos = { diag.lnum + 1, diag.col },
								end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
							}
						end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
					end,
					action = function(match, state)
						vim.api.nvim_win_call(match.win, function()
							vim.api.nvim_win_set_cursor(match.win, match.pos)
							vim.diagnostic.open_float()
						end)
						state:restore()
					end,
				})
			end,
			desc = "Show diagnostics at target",
		},
		{
			"<c-space>",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter({
					actions = {
						["<c-space>"] = "next",
						["<BS>"] = "prev",
					},
				})
			end,
			desc = "Treesitter incremental selection",
		},
	},
}
