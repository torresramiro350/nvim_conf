return {
	"echasnovski/mini.statusline",
	version = false,
	event = { "VimEnter" },
	opts = function()
		-- Autocmd to track macro recording, And redraw statusline, which trigger
		-- macro function of mini.statusline
		vim.api.nvim_create_autocmd("RecordingEnter", {
			pattern = "*",
			callback = function()
				vim.cmd("redrawstatus")
			end,
		})
		-- Autocmd to track the end of macro recording
		vim.api.nvim_create_autocmd("RecordingLeave", {
			pattern = "*",
			callback = function()
				vim.cmd("redrawstatus")
			end,
		})
		local opts = {
			use_icons = vim.g.have_nerd_font,
			content = {
				active = function()
					local check_macro_recording = function()
						if vim.fn.reg_recording() ~= "" then
							return "recording @" .. vim.fn.reg_recording()
						else
							return ""
						end
					end
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
					local filename = MiniStatusline.section_filename({ trunc_width = 140 })
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location = MiniStatusline.section_location({ trunc_width = 75 })
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
					local macro = check_macro_recording()
					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode:upper() } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
						"%<", -- Mark general truncate point
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=", -- End left alignment
						{ hl = "MiniStatuslineFilename", strings = { macro } },
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl, strings = { search, location } },
					})
				end,
			},
		}
		return opts
	end,
	config = function(_, opts)
		local statusline = require("mini.statusline")
		statusline.setup(opts)
	end,
}
