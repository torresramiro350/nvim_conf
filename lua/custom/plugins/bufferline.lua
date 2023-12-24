-- Bufferline
return {
  'akinsho/bufferline.nvim',
  lazy = true,
  event = "BufEnter",
  config = function()
    -- vim.opt.termguicolors = true
    vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
    vim.keymap.set("n", "<s-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })
    vim.keymap.set("n", "<leader>bc", "<cmd>BufferLineCloseOthers<cr>", { desc = "Previous tab" })
    vim.keymap.set("n", "<leader>bq", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Close group" })

    require("bufferline").setup {}
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
}
