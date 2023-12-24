return {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      -- vim.cmd("colorscheme kanagawa")
    end,
    priority = 1000
  },
  { "catppuccin/nvim",     name = "catppuccin", priority = 1000, lazy = true, },
  { 'Mofiqul/vscode.nvim', priority = 1000,     lazy = true, },
  { "Shatur/neovim-ayu",   priority = 1000,     lazy = true, },
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    config = function()
      styles = {
        comment = { italic = false },
        keyword = { italic = false },
      }
    end

  }
}
