-- Git integration plugins placed here
return {
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		cond = function()
			-- enable plugins only within a git repo
			local current_dir = vim.fn.getcwd()
			local git_dir = current_dir .. "/.git"
			return vim.fn.isdirectory(git_dir) == 1
		end,
		config = function()
			local git_blame = require("gitblame")
			require("lualine").setup({
				--
			})
		end,
	},
	{ "tpope/vim-rhubarb",  event = "VeryLazy" },
	-- allows the integration of git functionality within neovim
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		cond = function()
			-- enable plugins only within a git repo
			local current_dir = vim.fn.getcwd()
			local git_dir = current_dir .. "/.git"
			return vim.fn.isdirectory(git_dir) == 1
		end,
		opts = {
			signs = {
				-- add = { text = "+" },
				-- change = { text = "~" },
				-- delete = { text = "|" },
				-- topdelete = { text = "‾" },
				-- changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>hp",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "Preview git hunk" }
				)

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({ "n", "v" }, "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ "n", "v" }, "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
			end,
		},
	},
}
