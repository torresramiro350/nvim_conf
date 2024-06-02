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

    dboard_base.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    -- dboard_base.section.header.val = {
    --   "           ▄ ▄                   ",
    --   "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
    --   "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
    --   "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
    --   "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
    --   "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
    --   "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
    --   "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
    --   "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    -- }

    -- dashboard.buttons.val = {
    dboard_base.section.buttons.val = {
      dboard_base.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
      dboard_base.button("d", "  Show current directory", "<cmd>Telescope file_browser<CR>"),
      dboard_base.button("e", "  New file", "<cmd> ene <BAR> startinsert <CR>"),
      dboard_base.button("r", "󰄉  Recently used files", "<cmd>Telescope oldfiles<CR>"),
      dboard_base.button("t", "󱄽  Find text", "<cmd>Telescope live_grep<CR>"),
      dboard_base.button("c", "  Configuration", "<cmd>e ~/.config/nvim/init.lua<CR>"),
      dboard_base.button("l", "󰒲   Lazy", "<cmd>Lazy<CR>"),
      dboard_base.button("m", "  Mason", "<cmd>Mason<CR>"),
      dboard_base.button("u", "󰂖   Update plugins", "<cmd>Lazy sync <CR>"),
      dboard_base.button("q", "󰅚  Quit Neovim", "<cmd>qa<CR>"),
    }
    vim.api.nvim_create_autocmd("User", {
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100) / 100
        dboard_base.section.footer.val = {
          "󱐌 " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. " ms",
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    -- alpha.setup(dashboard.config)
    alpha.setup(dboard_base.config)
    -- alpha.setup(dashboard.config)
  end,
}
