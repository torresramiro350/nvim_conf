return {
  "freddiehaddad/feline.nvim",
  -- config = function(_, opts)
  config = function()
    -- SIMPLER SETUP
    local ctp_feline = require("catppuccin.groups.integrations.feline")

    ctp_feline.setup({
      --- default setup
      inactive = {
        -- "file_info",
      },
      view = {
        lsp = {
          progress = true,
          name = false,
          separator = "|",
          exclude_lsp_names = { "null-ls", "copilot" },
        },
      },
    })

    require("feline").setup({
      components = ctp_feline.get(),
    })
  end,
  -- priority = 1000,
  after = "catppuccin",
  event = "UIEnter",
}
