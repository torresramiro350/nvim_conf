return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    require("rainbow-delimiters.setup").setup({
      -- call options here
    })
  end,
  -- when starting to edit a new buffer
  event = { "BufNewFile", "BufReadPost", "BufReadPre" },
}
