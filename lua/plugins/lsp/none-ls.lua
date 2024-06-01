return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      -- define the sources
      timeout = 2000,
      sources = {
        -- mostly used for yaml and json (I don't use it for other filetypes)
        null_ls.builtins.formatting.prettierd.with({
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "yaml" },
        }),
        -- markdown
        null_ls.builtins.formatting.markdownlint.with({
          filetypes = { "markdown" },
        }),
        -- lua
        null_ls.builtins.formatting.stylua.with({
          filetypes = { "lua" },
        }),
        --python
        null_ls.builtins.formatting.isort.with({
          filetypes = { "python" },
          extra_args = { "--profile", "black" },
        }),
        -- cmake
        null_ls.builtins.formatting.cmake_format.with({
          filetypes = { "cmake" },
        }),
        null_ls.builtins.diagnostics.cmake_lint.with({
          filetypes = { "cmake" },
        }),
        -- bash
        null_ls.builtins.formatting.shfmt.with({
          filetypes = { "sh", "bash", "zsh" },
        }),
        -- null_ls.builtins.diagnostics.vale.with({
        -- 	filetypes = { "tex", "bib" },
        -- }),
      },
    })
  end,
  -- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" }),
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
}
