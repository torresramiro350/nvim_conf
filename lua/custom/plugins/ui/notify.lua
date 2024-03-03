return {
  event = "VeryLazy",
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require("notify")
    local notify = require("notify")
    notify.setup({
      timeout = 2000,
      -- render = "compact",
      render = "wrapped-compact",
      stages = "fade",
    })
  end,
}
