function nmap(mode, keys, func, additional_args)
	additional_args = additional_args or {}
	vim.keymap.set(mode, keys, func, additional_args)
end

function nmap_api(mode, keys, func, additional_args)
	additional_args = additional_args or {}
	vim.api.nvim_set_keymap(mode, keys, func, additional_args)
end
