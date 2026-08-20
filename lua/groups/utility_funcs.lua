-- check whether we are within a git repo
-- search for the `.git` repo in the current working directory, from the current directory
-- up to through parent directories
function in_git()
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir ~= "" then
		return true
	end
end

-- small utility function to make defining keymaps easier
function nmap(mode, keys, func, additional_args)
	additional_args = additional_args or {}
	vim.keymap.set(mode, keys, func, additional_args)
end

-- small utility function to make defining keymaps easier
function nmap_api(mode, keys, func, additional_args)
	additional_args = additional_args or {}
	vim.api.nvim_set_keymap(mode, keys, func, additional_args)
end
