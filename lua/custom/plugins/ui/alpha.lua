return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
      return
    end

    local alpha = require("alpha")
    local dashboard = require("alpha.themes.theta")
    local dboard_base = require("alpha.themes.dashboard")

    dashboard.header.val = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    }
    dashboard.buttons.val = {
      dboard_base.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
      dboard_base.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dboard_base.button("r", "󰄉  Recently used files", ":Telescope oldfiles <CR>"),
      dboard_base.button("t", "󱄽  Find text", ":Telescope live_grep <CR>"),
      dboard_base.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
      dboard_base.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
    }
    -- alpha.setup(dashboard.config)
    vim.api.nvim_create_autocmd("User", {
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100) / 100
        dboard_base.section.footer.val = "= Lazy-loaded " .. "/" .. stats.count .. " plugins in " .. ms .. " ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    alpha.setup(dashboard.config)
  end,
}
