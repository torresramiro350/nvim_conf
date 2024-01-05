return {
  "topaxi/gh-actions.nvim",
  cmd = "GhActions",
  keys = {
    { "<leader>gh", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
  },
  -- optional, you can also install and use `yq` instead.
  build = "make",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  -- opts = {},
  config = function(_, opts)
    require("gh-actions").setup(opts)
  end,
  event = "VeryLazy",
  cond = function()
    -- enable plugins only within a git repo
    local current_dir = vim.fn.getcwd()
    local git_dir = current_dir .. "/.git"
    return vim.fn.isdirectory(git_dir) == 1
  end,
}
