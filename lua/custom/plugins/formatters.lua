return {
  "stevearc/conform.nvim",
  -- load the plugin when reading an already existing file or starting a new one
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { "isort", "mypy" },
        sh = { "beautysh" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        -- if async is set to false, then the timout is ignored
        async = false,
        lsp_fallback = true,
      },
    })
  end,
}
