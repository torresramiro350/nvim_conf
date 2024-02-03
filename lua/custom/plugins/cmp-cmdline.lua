return {
	"hrsh7th/cmp-cmdline",
	-- config = function() end,
	dependencies = {
		{ "hrsh7th/cmp-buffer", event = "CmdLineEnter" },
		{ "hrsh7th/cmp-path",   event = "CmdLineEnter" },
	},
	event = { "CmdLineEnter", "InsertEnter" },
}
