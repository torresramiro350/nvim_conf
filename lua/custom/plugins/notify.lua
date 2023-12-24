return {
  -- lazy = true,
  event = "VeryLazy",
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require("notify")
  end
}
