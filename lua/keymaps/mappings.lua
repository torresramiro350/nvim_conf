---@module Mappings for neovim
---@author R. Torres-Escobedo
---@date Feb 23, 2024
---@version

-- small utility function to make defining keymaps easier
local nmap = function(mode, keys, func, additional_args)
	additional_args = additional_args or {}
	vim.keymap.set(mode, keys, func, additional_args)
end
local nmap_api = function(mode, keys, func, additional_args)
	additional_args = additional_args or {}
	vim.api.nvim_set_keymap(mode, keys, func, additional_args)
end

-- navigating buffers
nmap_api("n", "bh", "<cmd>bprevious<cr>", { noremap = false })
nmap_api("n", "bl", "<cmd>bnext<cr>", { noremap = false })
nmap_api("n", "bk", "<cmd>bfirst<cr>", { noremap = false })
nmap_api("n", "bj", "<cmd>blast<cr>", { noremap = false })
nmap_api("n", "bd", "<cmd>bdelete<cr>", { noremap = false })

-- copilot keymaps if tab mapping is used by another plugin
-- not using bufferline for now
-- nmap("i", "<C-E>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
nmap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- some mappings for making life easier
nmap("n", "<leader>q", "<cmd>qa<cr>", { desc = "Close all buffers" })
-- for much easier access to escape
nmap("i", "jj", "<Esc>", { desc = "Escape insert mode" })

-- split buffers
nmap("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
nmap("n", "\\", "<cmd>split<cr>", { desc = "Horizontal split" })
nmap("n", "<C-q>", "<C-w>q", { desc = "Close split buffer" })
nmap("n", "<C-s>", "<cmd>w<cr>", { desc = "Save changes" })

-- moving between buffers

-- Remap for dealing with word wrap
-- nmap("n", "k", "v:count == 0 ? 'gk' : 'k'", )
nmap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
nmap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- making life easier here
-- vim.keymap.set('n', '<leader>w', "<cmd>s<cr>", {desc = "Save"} )

-- Diagnostic keymaps
nmap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
nmap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
nmap("n", "<leader>fd", vim.diagnostic.open_float, { desc = "Open [F]loating [D]iagnostic message" })
nmap("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open [D]iagnostics [L]ist" })

-- NOTE: these keybindings are for usage without smart-splits
nmap("n", "<C-j>", "<c-w>j", { desc = "Move to lower split" })
nmap("n", "<C-k>", "<c-w>k", { desc = "Move to upper split" })
nmap("n", "<C-h>", "<c-w>h", { desc = "Move to left split" })
nmap("n", "<C-h>", "<c-w>l", { desc = "Move to right split" })
-- resize split lines
nmap("n", "<C-up>", "<cmd>resize -2<cr>", { desc = "Increase buffer size" })
nmap("n", "<C-down>", "<cmd>resize +2<cr>", { desc = "Increase buffer size down" })
nmap("n", "<C-left>", "<cmd>vertical resize -2<cr>", { desc = "Resize split left" })
nmap("n", "<C-right>", "<cmd>vertical resize +2<cr>", { desc = "Resize split right" })
