return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	keys = {
		{ "<leader>On", "<cmd>Obsidian new<cr>", desc = "New note" },
		{ "<leader>Ot", "<cmd>Obsidian new_from_template<cr>", desc = "New note from template" },
		{ "<leader>Ob", "<cmd>Obsidian backlinks<cr>", "List of references" },
		{
			"<leader>Ox",
			"<cmd>Obsidian extract_note<cr>",
			mode = { "n", "x" },
			desc = "Extract visually selected text to a note",
		},
	},
	opts = {
		-- disabling this in favor of the ui from render markdown as they might not play ncie
		-- with eachother:
		-- https://github.com/MeanderingProgrammer/render-markdown.nvim
		ui = { enable = false },
		legacy_commands = false,
		workspaces = {
			{ name = "work", path = "~/Documents/vaults/second-brain/" },
		},
		frontmatter = { enabled = true }, -- let the template's frontmatter be the only block
		templates = {
			folder = "templates",
			date_format = "YYYY-MM-DD",
			time_format = "HH:mm",
		},
		picker = {
			name = "snacks.pick",
		},
	},
}
