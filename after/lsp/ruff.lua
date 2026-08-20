-- local Lsp = require("utils.lsp")

return {
	-- on_attach = Lsp.on_attach,
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	cmd_env = { RUFF_TRACE = "messages" },
	init_options = {
		settings = {
			showSyntaxErrors = true,
			lint = { enable = true, preview = true },
			format = { preview = true },
			configurationPreference = "editorFirst",
			organizeImport = true,
			lineLength = 88,
			logLevel = "error",
			codeAction = {
				fixViolation = { enable = true },
				disableRuleComment = { enable = true },
			},
		},
	},
}
