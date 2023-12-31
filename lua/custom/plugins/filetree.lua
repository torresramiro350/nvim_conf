-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "BufEnter",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      source_selector = {
        winbar = false,
        statusline = false,
        show_scrolled_off_parent_node = false,
        pop_up_border_style = "rounded",
        sources = {
          {
            source = "filesystem", -- string
            display_name = " 󰉓 Files ", -- string | nil
          },
          {
            source = "buffers", -- string
            display_name = " 󰈚 Buffers ", -- string | nil
          },
          {
            source = "git_status", -- string
            display_name = " 󰊢 Git ", -- string | nil
          },
        },
      },
    })
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File list" })
  end,
}
