---@module Mappings for neovim
---@author R. Torres-Escobedo
---@date Feb 23, 2024

vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>:qa<cr>", { desc = "Close all buffers" })

-- some mappings for making life easier
vim.keymap.set("i", "jj", "<Esc>", { desc = "escape" })
-- vim.keymap.set("n", "<leader>s", "<cmd>w<cr>", { desc = "Save changes" })
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal split" })
vim.keymap.set("n", "<C-q>", "<C-w>q", { desc = "Close split buffer" })

vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right split" })

vim.keymap.set("n", "<C-up>", require("smart-splits").resize_up, { desc = "Resize buffer up" })
vim.keymap.set("n", "<C-down>", require("smart-splits").resize_down, { desc = "Resize buffer down" })
vim.keymap.set("n", "<C-left>", require("smart-splits").resize_left, { desc = "Resize buffer left" })
vim.keymap.set("n", "<C-right>", require("smart-splits").resize_right, { desc = "Resize buffer right" })

-- NOTE: these keybindings are for usage without smart-splits
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
-- -- resize split lines
-- vim.keymap.set("n", "<C-up>", "<cmd>resize -2<cr>", { desc = "Increase buffer size" })
-- vim.keymap.set("n", "<C-down>", "<cmd>resize +2<cr>", { desc = "Increase buffer size down" })
-- vim.keymap.set("n", "<C-left>", "<cmd>vertical resize -2<cr>", { desc = "Resize split left" })
-- vim.keymap.set("n", "<C-right>", "<cmd>vertical resize +2<cr>", { desc = "Resize split right" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- making life easier here
-- vim.keymap.set('n', '<leader>w', "<cmd>s<cr>", {desc = "Save"} )

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>o", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

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

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require("telescope.builtin").live_grep({
			search_dirs = { git_root },
		})
	end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
