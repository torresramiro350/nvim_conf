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
	defaults = {
		lazy = false, -- set to true for all plugins to be lazy loaded
		version = false, -- plugins with versions tend to be outdated often
	},
	checker = {
		enabled = true, -- check for plugin update periodically
		notify = false, -- notify of an update
	},
	{ import = "plugins.enhancements" },
	{ import = "plugins.tmux" },
	{ import = "plugins.completion" },
	{ import = "plugins.cpp" },
	{ import = "plugins.documentation" },
	{ import = "plugins.notes" },
	{ import = "plugins.git" },
	{ import = "plugins.lsp" },
	{ import = "plugins.sessions" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.ui" },
	{ import = "plugins.ai" },
})
