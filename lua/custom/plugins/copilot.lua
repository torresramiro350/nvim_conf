return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        -- prevent it from using the completion panel
        -- it may interrupt lsp completions
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          latex = false
        }

      }
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "AndreM222/copilot-lualine",
    event = "VeryLazy"
  }
}
