return {
	"freddiehaddad/feline.nvim",
	config = function(_, opts)
		-- SIMPLER SETUP
		local ctp_feline = require("catppuccin.groups.integrations.feline")

		ctp_feline.setup({
			--- default setup
			-- if no options are passed, then the defaults are kept
			assets = {
				left_separator = "",
				right_separator = "",
				dir = "󰉖",
				file = "󰈙",
				lsp = {
					server = "󰅡 ",
					error = " ",
					warning = " ",
					info = " ",
					hint = " ",
				},
				git = {
					branch = "",
					added = " ",
					changed = " ",
					removed = " ",
				},
			},
		})

		require("feline").setup({
			components = ctp_feline.get(),
		})
		-- MORE COMPLICATED SETUP
		-- local line_ok, feline = pcall(require, "feline")
		-- if not line_ok then
		-- 	return
		-- end
		--
		-- local catppuccin = require("catppuccin.palettes").get_palette("mocha")
		--
		-- local vi_mode_colors = {
		-- 	NORMAL = catppuccin.lavender,
		-- 	OP = catppuccin.green,
		-- 	INSERT = catppuccin.green,
		-- 	VISUAL = catppuccin.mauve,
		-- 	LINES = catppuccin.peach,
		-- 	BLOCK = catppuccin.red,
		-- 	REPLACE = catppuccin.maroon,
		-- 	COMMAND = catppuccin.blue,
		-- }
		--
		-- local c = {
		-- 	vim_mode = {
		-- 		provider = {
		-- 			name = "vi_mode",
		-- 			opts = {
		-- 				show_mode_name = true,
		-- 				-- padding = "center", -- Uncomment for extra padding.
		-- 			},
		-- 		},
		-- 		hl = function()
		-- 			return {
		-- 				fg = require("feline.providers.vi_mode").get_mode_color(),
		-- 				bg = "#1E1E2F",
		-- 				style = "bold",
		-- 				name = "NeovimModeHLColor",
		-- 			}
		-- 		end,
		-- 		left_sep = "block",
		-- 		right_sep = "",
		-- 		-- left_sec=""
		-- 	},
		-- 	gitBranch = {
		-- 		provider = "git_branch",
		-- 		hl = {
		-- 			fg = catppuccin.flamingo,
		-- 			bg = "#1E1E2F",
		-- 			style = "bold",
		-- 		},
		-- 		left_sep = "block",
		-- 		right_sep = "block",
		-- 		-- left_sec = "",
		-- 		-- right_sep = "",
		-- 	},
		-- 	gitDiffAdded = {
		-- 		provider = "git_diff_added",
		-- 		hl = {
		-- 			fg = catppuccin.teal,
		-- 			bg = "#1E1E2F",
		-- 		},
		-- 		left_sep = "",
		-- 		right_sep = "",
		-- 		-- left_sep = "block",
		-- 		-- right_sep = "block",
		-- 	},
		-- 	gitDiffRemoved = {
		-- 		provider = "git_diff_removed",
		-- 		hl = {
		-- 			fg = catppuccin.maroon,
		-- 			bg = "#1E1E2F",
		-- 		},
		-- 		left_sep = "",
		-- 		right_sep = "",
		-- 		-- left_sep = "block",
		-- 		-- right_sep = "block",
		-- 	},
		-- 	gitDiffChanged = {
		-- 		provider = "git_diff_changed",
		-- 		hl = {
		-- 			-- fg = "fg",
		-- 			fg = catppuccin.subtext0,
		-- 			bg = "#1E1E2F",
		-- 		},
		-- 		left_sep = "",
		-- 		-- left_sep = "block",
		-- 		right_sep = "right_filled",
		-- 	},
		-- 	separator = {
		-- 		provider = "",
		-- 		hl = {
		-- 			bg = "#1E1E2F",
		-- 		},
		-- 	},
		-- 	fileinfo = {
		-- 		provider = {
		-- 			name = "file_info",
		-- 			opts = {
		-- 				type = "relative-short",
		-- 			},
		-- 		},
		-- 		hl = {
		-- 			fg = catppuccin.subtext0,
		-- 			bg = "#1E1E2F",
		-- 			style = "bold",
		-- 		},
		-- 		left_sep = " ",
		-- 		right_sep = " ",
		-- 	},
		-- 	diagnostic_errors = {
		-- 		provider = "diagnostic_errors",
		-- 		hl = {
		-- 			fg = catppuccin.maroon,
		-- 			bg = "#1E1E2F",
		-- 		},
		-- 	},
		-- 	diagnostic_warnings = {
		-- 		provider = "diagnostic_warnings",
		-- 		hl = {
		-- 			fg = catppuccin.yellow,
		-- 			bg = "#1E1E2F",
		-- 		},
		-- 	},
		-- 	diagnostic_hints = {
		-- 		provider = "diagnostic_hints",
		-- 		hl = {
		-- 			fg = catppuccin.sky,
		-- 			bg = "#1E1E2F",
		-- 		},
		-- 	},
		-- 	diagnostic_info = {
		-- 		provider = "diagnostic_info",
		-- 	},
		-- 	lsp_client_names = {
		-- 		provider = "lsp_client_names",
		-- 		hl = {
		-- 			fg = catppuccin.mauve,
		-- 			bg = "#1E1E2F",
		-- 			style = "bold",
		-- 		},
		-- 		left_sep = "left_filled",
		-- 		right_sep = "block",
		-- 	},
		-- 	file_type = {
		-- 		provider = {
		-- 			name = "file_type",
		-- 			opts = {
		-- 				filetype_icon = true,
		-- 				case = "titlecase",
		-- 			},
		-- 		},
		-- 		hl = {
		-- 			fg = catppuccin.maroon,
		-- 			-- bg = catppuccin.mantle,
		-- 			bg = "#1E1E2F",
		-- 			style = "bold",
		-- 		},
		-- 		left_sep = "block",
		-- 		right_sep = "block",
		-- 	},
		-- 	file_encoding = {
		-- 		provider = "file_encoding",
		-- 		hl = {
		-- 			fg = catppuccin.peach,
		-- 			-- bg = catppuccin.mantle,
		-- 			bg = "#1E1E2F",
		-- 			style = "italic",
		-- 		},
		-- 		left_sep = "block",
		-- 		right_sep = "block",
		-- 	},
		-- 	position = {
		-- 		provider = "position",
		-- 		hl = {
		-- 			fg = catppuccin.green,
		-- 			bg = "#1E1E2F",
		-- 			-- bg = catppuccin.mantle,
		-- 			style = "bold",
		-- 		},
		-- 		left_sep = "block",
		-- 		right_sep = "block",
		-- 	},
		-- 	line_percentage = {
		-- 		provider = "line_percentage",
		-- 		hl = {
		-- 			fg = catppuccin.sky,
		-- 			bg = "#1E1E2F",
		-- 			style = "bold",
		-- 		},
		-- 		left_sep = "block",
		-- 		right_sep = "block",
		-- 	},
		-- 	scroll_bar = {
		-- 		provider = "scroll_bar",
		-- 		hl = {
		-- 			fg = catppuccin.yellow,
		-- 			bg = "#1E1E2F",
		-- 			style = "bold",
		-- 		},
		-- 	},
		-- }
		--
		-- local left = {
		-- 	c.vim_mode,
		-- 	c.gitBranch,
		-- 	c.gitDiffAdded,
		-- 	c.gitDiffRemoved,
		-- 	c.gitDiffChanged,
		-- 	c.separator,
		-- }
		--
		-- local middle = {
		-- 	c.fileinfo,
		-- 	c.diagnostic_errors,
		-- 	c.diagnostic_warnings,
		-- 	c.diagnostic_info,
		-- 	c.diagnostic_hints,
		-- }
		--
		-- local right = {
		-- 	c.lsp_client_names,
		-- 	c.file_type,
		-- 	c.file_encoding,
		-- 	c.position,
		-- 	c.line_percentage,
		-- 	c.scroll_bar,
		-- }
		--
		-- local components = {
		-- 	active = {
		-- 		left,
		-- 		middle,
		-- 		right,
		-- 	},
		-- 	inactive = {
		-- 		-- left,
		-- 		-- middle,
		-- 		-- right,
		-- 	},
		-- }
		-- feline.setup({ components = components, theme = catppuccin, vi_mode_colors = vi_mode_colors })
	end,
	event = "UIEnter",
}
