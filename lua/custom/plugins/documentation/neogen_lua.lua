return {
  "danymat/neogen",
  config = function()
    -- adding some keybindings
    -- local opts = { noremap = true, silent = true }
    require("neogen").setup({
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
            -- annotation_convention = "reST",
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
    })
  end,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "InsertEnter" },
}
