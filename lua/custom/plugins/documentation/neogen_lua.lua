return {
  "danymat/neogen",
  config = function()
    -- adding some keybindings
    -- local opts = { noremap = true, silent = true }
    local nmap = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { desc = desc })
    end
    -- Neogen keymaps
    -- leaving the keymappings here, otherwise the plugin is loaded
    -- unnecessarily at startup
    nmap("n", "<leader>nf", "<cmd>Neogen func<cr>", "Generate func docs ")
    nmap("n", "<leader>nc", "<cmd>Neogen class<cr>", "Generate class docs ")
    nmap("n", "<leader>nF", "<cmd>Neogen file<cr>", "Generate file docs ")
    nmap("i", "<C-l>", require("neogen").jump_next, "Jump to next annotation")
    nmap("i", "<C-h>", require("neogen").jump_prev, "Jump to previous annotation")
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
