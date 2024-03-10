---@module Mappings for neovim
---@author R. Torres-Escobedo
---@date Feb 23, 2024

-- small utility function to make defining keymaps easier
local nmap = function(mode, keys, func, desc)
	vim.keymap.set(mode, keys, func, { desc = desc })
end
local nmap_especial = function(mode, keys, func, desc, noremap)
	vim.keymap.set(mode, keys, func, { desc = desc }, { noremap = noremap })
end

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- COPILOT
vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- some mappings for making life easier
nmap("n", "<leader>q", "<cmd>:qa<cr>", "Close all buffers")
nmap("i", "jj", "<Esc>", "escape")

-- SPLIT BUFFERS
nmap("n", "|", "<cmd>vsplit<cr>", "Vertical split")
nmap("n", "\\", "<cmd>split<cr>", "Horizontal split")
nmap("n", "<C-q>", "<C-w>q", "Close split buffer")
-- vim.keymap.set("n", "<leader>s", "<cmd>w<cr>", { desc = "Save changes" })

local splits = require("smart-splits")

-- moving between buffers
nmap("n", "<C-h>", splits.move_cursor_left, "Move to left split")
nmap("n", "<C-l>", splits.move_cursor_right, "Move to right split")
nmap("n", "<C-j>", splits.move_cursor_down, "Move to lower split")
nmap("n", "<C-k>", splits.move_cursor_up, "Move to upper split")

nmap("n", "<C-Up>", splits.resize_up, "Increase buffer size")
nmap("n", "<C-Down>", splits.resize_down, "Increase buffer size down")
nmap("n", "<C-Left>", splits.resize_left, "Resize split left")
nmap("n", "<C-Right>", splits.resize_right, "Resize split right")

-- NOTE: these keybindings are for usage without smart-splits
-- nmap("n", "<C-j>", "<C-w>j", "Move to lower split")
-- nmap("n", "<C-k>", "<C-w>k", nmap")
-- vim.keymap.set("n", "<C-h>", "<C-w>h", nmap")
-- vim.keymap.set("n", "<C-l>", "<C-w>l", "Move to right split")
-- -- resize split lines
-- nmap("n", "<C-up>", "<cmd>resize -2<cr>", "Increase buffer size")
-- nmap("n", "<C-down>", "<cmd>resize +2<cr>", "Increase buffer size down")
-- nmap("n", "<C-left>", "<cmd>vertical resize -2<cr>", "Resize split left")
-- nmap("n", "<C-right>", "<cmd>vertical resize +2<cr>", "Resize split right")

-- Remap for dealing with word wrap
-- nmap("n", "k", "v:count == 0 ? 'gk' : 'k'", )
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- making life easier here
-- vim.keymap.set('n', '<leader>w', "<cmd>s<cr>", {desc = "Save"} )

-- Diagnostic keymaps
nmap("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
nmap("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
nmap("n", "<leader>d", vim.diagnostic.open_float, "Open floating diagnostic message")
nmap("n", "<leader>o", vim.diagnostic.setloclist, "Open diagnostics list")

-- TELESCOPE
local tel_bin = require("telescope.builtin")
local tel = require("telescope")
local tel_themes = require("telescope.themes")
-- Enable telescope fzf native, if installed
pcall(tel.load_extension, "fzf")

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		tel_bin.live_grep({ search_dirs = { git_root } })
	end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

nmap("n", "<leader>?", tel_bin.oldfiles, "[?] Find recently opened files")
nmap("n", "<leader><space>", tel_bin.buffers, "[ ] Find existing buffers")
nmap("n", "<leader>/", function()
	tel_bin.current_buffer_fuzzy_find(tel_themes.get_dropdown({
		winblend = 10,
		previewer = true,
	}))
end, "[/] Fuzzily search in current buffer")

nmap_especial("n", "<leader>fb", tel.extensions.file_browser.file_browser, "File Browser", true)
nmap("n", "<leader>gf", tel_bin.git_files, "Search [G]it [F]iles")
nmap("n", "<leader>sf", tel_bin.find_files, "[S]earch [F]iles")
nmap("n", "<leader>sh", tel_bin.help_tags, "[S]earch [H]elp")
nmap("n", "<leader>sw", tel_bin.grep_string, "[S]earch current [W]ord")
nmap("n", "<leader>sg", tel_bin.live_grep, "[S]earch by [G]rep")
nmap("n", "<leader>sd", tel_bin.diagnostics, "[S]earch [D]iagnostics")
nmap("n", "<leader>sr", tel_bin.resume, "[S]earch [R]esume")
nmap("n", "<leader>sG", ":LiveGrepGitRoot<cr>", "[S]earch by [G]rep on Git Root")
