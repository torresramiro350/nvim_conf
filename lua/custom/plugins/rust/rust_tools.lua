return {

  "mrcjkb/rustaceanvim",
  -- lazy = false,
  -- event = "VeryLazy",
  priority = 1000,
  version = "^4", -- Recommended
  ft = { "rust" },
  config = function()
    local nmap = function(mode, keys, func, additional_args)
      additional_args = additional_args or {}
      vim.keymap.set(mode, keys, func, additional_args)
    end
    vim.g.rustaceanvim = {
      float_win_config = {
        auto_focus = true,
        open_split = "vertical",
      },
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- you can also put keymaps in here
          nmap("n", "<leader>a", function()
            -- or vim.lsp.buf.codeAction() if you don't want grouping.
            vim.cmd.RustLsp("codeAction")
          end, { silent = true, buffer = bufnr })

          nmap("n", "<s-k>", function()
            vim.cmd.RustLsp({ "hover", "actions" })
            -- vim.lsp.buf.hover()
          end)
          nmap("n", "<leader>df", function()
            vim.cmd.RustLsp("explainError")
          end)
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            -- diagnostics = { enable = true },
          },
        },
      },
      -- DAP configuration
      dap = {},
    }
  end,
}
