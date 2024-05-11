---@module init.lua Main configuration for neovim
---@author Ramiro (using Kickstart nvim as base)

-- NOTE: load in the general options to use with vim
require("vim_options.essential")

-- Load lazyvim's configuration
require("lazyvim.init")

-- load all the keymaps to a separate file
require("keymaps.mappings")
require("groups.init")

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
-- require("mason").setup()
-- require("mason-lspconfig").setup({
--   -- ensure_installed = {}
-- })

-- -- Setup neovim lua configuration
-- require("neodev").setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim.g.material_style = "darker"
-- vim.cmd("colorscheme material")
vim.cmd("colorscheme catppuccin-mocha")
