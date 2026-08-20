return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "rcarriga/nvim-notify",
	},
	priority = 1000,
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		notify = { enabled = false },
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	},
	keys = {
  -- stylua: ignore start
    { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Show last message in popup", },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Show history of messages in popup" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice picker (Telescope/fzf lua)" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice all" },
    { "<leader>snd", function() require("noice").cmd("dismis") end,  desc = "Noice dismiss" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>",
      function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
      silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"}
    },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
      silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}
    },
		-- stylua: ignore end
	},
	config = function(_, opts)
		require("noice").setup(opts)
		-- if vim.o.filetype == "lazy" then
		-- 	vim.cmd([[messages clear]])
		-- else
		-- 	require("noice").setup(opts)
		-- end
	end,
}
