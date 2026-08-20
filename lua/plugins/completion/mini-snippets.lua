return {
	"echasnovski/mini.snippets",
	event = "InsertEnter",
	dependencies = "rafamadriz/friendly-snippets",
	version = false,
	opts = function()
		local mini_snippets = require("mini.snippets")
		local blink = require("blink.cmp")
		local expand_select_override = function(snippets, insert)
			blink.cancel()
			vim.schedule(function()
				MiniSnippets.default_select(snippets, insert)
			end)
		end
		return {
			snippets = {
				mini_snippets.gen_loader.from_lang({ lang_patterns = { markdown_inline = { "markdown.json" } } }),
			},
			expand = {
				select = function(snippets, insert)
					-- Close completion window on snippet select - vim.ui.select
					-- Needed to remove virtual text for fzf-lua and telescope, but not for mini.pick...
					local select = expand_select_override or MiniSnippets.default_select
					select(snippets, insert)
				end,
			},
		}
	end,
	config = function(_, opts)
		require("mini.snippets").setup(opts)
	end,
}
