-- local Lsp = require("utils.lsp")
return {
	filetypes = { "lua" },
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			diagnositcs = {
				global = { "vim", "require" },
			},
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			codeLens = { enable = true },
			completion = {
				callSnippet = "Replace",
			},
			doc = {
				privateName = { "^_" },
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
		},
	},
}
