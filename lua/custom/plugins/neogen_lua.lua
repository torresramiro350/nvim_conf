return {
  "danymat/neogen",
  config = function()
    -- adding some keybindings
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_set_keymap
    map("n", "<leader>1", ":lua require('neogen').generate({type = 'func' })<CR>", opts)
    map("n", "<leader>2", ":lua require('neogen').generate({type = 'class' })<CR>", opts)
    map("n", "<leader>3", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)

    require("neogen").setup {
      enabled = true,
      input_after_comment = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "emmylua",
          },
        },
        python = {
          template = {
            annotation_convention = "numpydoc",
          },
        },
        cpp = {
          template = {
            annotation_convention = "doxygen",
          },
        },
        rust = {
          template = {
            annotation_convention = "rustdoc",
          },
        },
        sh = {
          template = {
            annotation_convention = "google_bash",
          },
        },
      },
    }
  end,
  requires = "nvim-treesitter/nvim-treesitter",
  lazy = true,
  event = "InsertEnter"
}
