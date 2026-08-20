return {
	"echasnovski/mini.icons",
	-- event = "VimEnter",
	lazy = true,
	version = false,
	enabled = true,
	opts = {
		files = {
			["bash.tmpl"] = { glyph = "", hl = "MiniIconsGreen" },
			["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
			["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
			["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
			["toml.tmpl"] = { glyph = "", hl = "MiniIconsRed" },
			["yaml.tmpl"] = { glyph = "", hl = "MiniIconsRed" },
			["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGreen" },
		},
		filetype = {
			dotenv = { glyph = "", hl = "MiniIconsYellow" },
		},
		style = "glyph",
	},
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
}
