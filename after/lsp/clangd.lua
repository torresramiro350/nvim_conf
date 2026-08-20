-- local Lsp = require("utils.lsp")
return {
	-- on_attach = Lsp.on_attach,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	capabilities = {
		textDocument = { completion = { editsNearCursor = true } },
		offsetEncoding = { "utf-16" },
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
		fallbackFlags = { "-std=c++17" },
	},
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
	},
}
