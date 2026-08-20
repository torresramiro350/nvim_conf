return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		ft = { "markdown", "norg", "rmd", "org", "codecompanion", "blink-cmp-documentation", "blink-cmp-signature" },
		opts = {
			dash = { width = 100 },
			checkbox = {
				custom = {
					important = {
						raw = "[~]",
						rendered = "󰓎 ",
						highlight = "DiagnosticWarn",
					},
				},
			},
			pipe_table = { preset = "round" },
			heading = {
				sign = false,
				-- icons = { "󰼏 ", "󰎨 " },
				icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
				border = false,
				min_width = 100,
				width = "block",
			},
			code = {
				sign = false,
				width = "block",
				min_width = 100,
				position = "left",
				border = "thick",
				right_pad = 1,
			},
			completions = {
				-- leaving this as disabled (since it breaks functionality with blink)
				-- blink = { enabled = true },
				lsp = { enabled = true },
				-- the code below seems to work
			},
		},
		config = function(_, opts)
			local render = require("render-markdown")
			render.setup(opts)
			Snacks.toggle({
				name = "Render Markdown",
				get = function()
					return require("render-markdown.state").enabled
				end,
				set = function(enabled)
					local m = require("render-markdown")
					if enabled then
						m.enable()
					else
						m.disable()
					end
				end,
			}):map("<leader>um")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = "markdown",
		enabled = false,
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{
				"<leader>cp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		config = function()
			vim.cmd([[do FileType]])
		end,
	},
}
