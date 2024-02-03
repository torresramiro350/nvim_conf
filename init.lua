---@module Main configuration for neovim
---@author Ramiro (using Kickstart nvim)

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
require("vim_options.essential")

-- NOTE: Here is where you install your plugins.
-- Load lazyvim's configuration
require("lazyvim.init")

-- load all the keymaps to a separate file
require("keymaps.mappings")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- document existing key chains
require("which-key").register({
  ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
  ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
  ["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
  ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
  ["<leader>p"] = { name = "[P]ull Request", _ = "which_key_ignore" },
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup({
  -- ensure_installed = {}
})

-- Setup neovim lua configuration
require("neodev").setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.g.material_style = "darker"
vim.cmd("colorscheme material")
-- vim.cmd("colorscheme nordic")
-- vim.cmd("colorscheme tokyonight-moon")
-- vim.cmd("colorscheme tokyonight")
