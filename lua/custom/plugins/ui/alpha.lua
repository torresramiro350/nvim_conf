return {
	"goolord/alpha-nvim",
	lazy = true,
	event = "VimEnter",
	config = function()
		--   -- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		-- require("alpha").setup(require("alpha.themes.startify").config)
		local status_ok, alpha = pcall(require, "alpha")
		if not status_ok then
			return
		end
		-- local dashboard = require("alpha").setup({ "alpha.themes.startify" })

		-- local dashboard = require("alpha.themes.dashboard")
		local dashboard = require("alpha.themes.startify")

		dashboard.nvim_web_devicons.highlight = true
		dashboard.section.header.val = {
			[[ ███       ███ ]],
			[[████      ████]],
			[[██████     █████]],
			[[███████    █████]],
			[[████████   █████]],
			[[█████████  █████]],
			[[█████ ████ █████]],
			[[█████  █████████]],
			[[█████   ████████]],
			[[█████    ███████]],
			[[█████     ██████]],
			[[████      ████]],
			[[ ███       ███ ]],
			[[                  ]],
			[[ N  E  O  V  I  M ]],
		}

		-- dashboard.section.header.val = {
		-- 	"           ▄ ▄                   ",
		-- 	"       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
		-- 	"       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
		-- 	"    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
		-- 	"  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
		-- 	"  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
		-- 	"▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
		-- 	"█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
		-- 	"    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
		-- }
		dashboard.section.top_buttons.val = {
			dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
			-- dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		}
		dashboard.section.bottom_buttons.val = {
			dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
