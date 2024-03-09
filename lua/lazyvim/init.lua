-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ import = "custom.plugins" },
	{ import = "custom.plugins.completion" },
	{ import = "custom.plugins.cpp" },
	{ import = "custom.plugins.documentation" },
	{ import = "custom.plugins.enhancements" },
	{ import = "custom.plugins.git" },
	{ import = "custom.plugins.lsp" },
	{ import = "custom.plugins.rust" },
	{ import = "custom.plugins.treesitter" },
	{ import = "custom.plugins.telescope" },
	{ import = "custom.plugins.ui" },
})
