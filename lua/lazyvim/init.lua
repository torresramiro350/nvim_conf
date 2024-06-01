-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
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
	-- { import = "custom.plugins" },
	{ import = "plugins.enhancements" },
	{ import = "plugins.completion" },
	{ import = "plugins.cpp" },
	{ import = "plugins.documentation" },
	{ import = "plugins.git" },
	{ import = "plugins.lsp" },
	{ import = "plugins.rust" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.telescope" },
	{ import = "plugins.tmux" },
	{ import = "plugins.ui" },
})
