function nmap(mode, keys, func, additional_args)
	additional_args = additional_args or {}
	vim.keymap.set(mode, keys, func, additional_args)
end
