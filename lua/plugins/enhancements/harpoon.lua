return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup({})
		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end
		--
		--
		local nmap = function(mode, keys, func, additional_args)
			additional_args = additional_args or {}
			vim.keymap.set(mode, keys, func, additional_args)
		end
    -- stylua: ignore start
    nmap("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    nmap("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Append to harpoon list" })
    nmap("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Toggle harpoon quick menu" })
    nmap("n", "<leader>hj", function() harpoon:list():select(1) end, { desc = "[H]arpoon list item 1" })
    nmap("n", "<leader>hk", function() harpoon:list():select(2) end, { desc = "[H]arpoon list item 2" })
    nmap("n", "<leader>hl", function() harpoon:list():select(3) end, { desc = "[H]arpoon list item 3" })
    nmap("n", "<leader>hh", function() harpoon:list():select(4) end, { desc = "[H]arpoon list item 4" })
    -- Toggle previous & next buffers stored within Harpoon list
    nmap("n", "<c-p>", function() harpoon:list():prev() end)
    nmap("n", "<c-n>", function() harpoon:list():next() end)
		-- stylua: ignore end
	end,
	event = { "BufReadPre", "BufReadPost" },
}
