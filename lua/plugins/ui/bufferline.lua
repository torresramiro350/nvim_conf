-- Bufferline
return {
  "akinsho/bufferline.nvim",
  -- load after catppuccin to ensure the correct highlighting
  enabled = false,
  event = { "BufNewFile", "BufReadPre", "BufReadPost" },
  config = function()
    local nmap = function(mode, keys, func, additional_args)
      additional_args = additional_args or {}
      vim.keymap.set(mode, keys, func, additional_args)
    end
    -- vim.opt.termguicolors = true
    nmap("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Close current buffer" })
    nmap("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
    nmap("n", "<s-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })
    -- vim.keymap.set("n", "[f", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
    -- vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })
    nmap("n", "<leader>ba", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close all other buffers" })
    nmap("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close next tab" })
    nmap("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close previous tab" })
    nmap("n", "<leader>bq", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Close group" })
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {

        -- style_preset = bufferline.style_preset.no_bold,
        separator_style = "slant",
        -- indicator = { style = "underline" },
        diagnostics = "nvim_lsp",
        hover = {
          enabled = true,
          delayed = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "NvimTree",
            -- filetype = "Neo-tree",
            -- text = "File Explorer",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            separator = true,
            text_align = "center",
          },
        },
      },
    })
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
