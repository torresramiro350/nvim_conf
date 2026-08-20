return {
	"pogyomo/cppguard.nvim",
	dependencies = {
		"echasnovski/mini.snippets",
	},
	event = { "BufNewFile", "BufRead", "BufReadPre" },
	ft = { "c", "cxx", "h", "hxx", "cpp", "objc", "objcpp", "cuda", "proto" },
}
