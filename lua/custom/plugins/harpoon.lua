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
		-- stylua: ignore start
		vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
		vim.keymap.set("n", "<leader>ab", function() harpoon:list():append() end)
		vim.keymap.set("n", "<A-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<A-j>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<A-k>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<A-l>", function() harpoon:list():select(4) end)
		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>bp", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<leader>bn", function() harpoon:list():next() end)
		-- stylua: ignore end
	end,
	-- event = { "BufEnter", "BufReadPost" },
}
