return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    -- priority = 1000,
    config = function()
      require("copilot").setup({
        -- prevent it from using the completion panel
        -- it may interrupt lsp completions
        suggestion = {
          auto_trigger = true,
          debounce = 150,
          enabled = false,
        },
        panel = { enabled = false },
        filetypes = {
          latex = false,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup({
        fix_pairs = true,
      })
    end,
  },
  {
    "AndreM222/copilot-lualine",
    event = "InsertEnter",
  },
}
