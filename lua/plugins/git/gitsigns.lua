-- Git integration plugins placed here
require("groups.utility_funcs")
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufReadPost" },
	enabled = true,
	cond = in_git(),
	opts = function()
		return {
			current_line_blame = true,
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gitsigns = package.loaded.gitsigns
				nmap("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Next Hunk" })
				nmap("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Prev Hunk" })
          -- stylua: ignore start
					nmap("n", "]H", function() gitsigns.nav_hunk("last") end, { buffer = bufnr, desc = "Last Hunk" })
					nmap("n", "[H", function() gitsigns.nav_hunk("first") end, { desc = "First Hunk" })
					nmap("n", "<leader>ghp", gitsigns.preview_hunk_inline, { desc = "Preview hunk line" })
					nmap("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					nmap("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk" })
          nmap('v', '<leader>ghs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc="Stage hunk" })
          nmap('v', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc="Reset hunk" })
					nmap("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					nmap("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
					nmap("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "Reset buffer" })
					nmap("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" })
					nmap("n", "<leader>ghB", function() gitsigns.blame() end, { desc = "Blame Buffer" })
					nmap("n", "<leader>ghd", gitsigns.diffthis, { desc = "Diff against index" })
					nmap("n", "<leader>ghD", function() gitsigns.diffthis("@") end, { desc = "Diff against last commit" })
					nmap({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "GitSigns Select Hunk" })
				-- stylua: ignore end
			end,
		}
	end,
	config = function(_, opts)
		-- local gitsigns = require("gitsigns")
		Snacks.toggle({
			name = "Git Signs",
			get = function()
				return require("gitsigns.config").config.signcolumn
			end,
			set = function(state)
				require("gitsigns").toggle_signs(state)
			end,
		}):map("<leader>uG")
		local gs = package.loaded.gitsigns
		gs.setup(opts)
	end,
}
