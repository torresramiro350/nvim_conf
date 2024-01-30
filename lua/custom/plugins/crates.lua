return {
	"saecki/crates.nvim",
	tag = "stable",
	config = function()
		require("crates").setup()
	end,
	-- ft = { "rust" },
	-- event = "VeryLazy",
	event = { "BufRead Cargo.toml" },
}
