---@module init.lua Main configuration for neovim
---@author Ramiro (using Kickstart nvim as base)

-- NOTE: load in the general options to use with vim
require("vim_options.essential")

-- Load lazyvim's configuration
require("lazyvim.init")

-- load all the keymaps to a separate file
require("keymaps.mappings")
require("groups.init")

vim.cmd("colorscheme catppuccin-mocha")
