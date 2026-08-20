return {
	"echasnovski/mini.surround",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		mappings = {
			add = "gsa",
			delete = "gsd",
			find = "gsf",
			find_left = "gsF",
			replace = "gsr",
			highlight = "gsh",
			update_n_lines = "gsn",
		},
		search_method = "cover",
		n_lines = 20,
	},
}
