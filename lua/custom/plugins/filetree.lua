-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  event = "BufEnter",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- require('neo-tree').setup {}
    vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = "File list" })
  end,
}
