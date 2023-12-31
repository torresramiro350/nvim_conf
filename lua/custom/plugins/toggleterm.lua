return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      start_in_insert = false,
      insert_mappings = false,
      cmd = { "ToggleTerm", "TermExec" },
      opts = {
        size = 10,
        -- open_mapping = [[<F7>]],
        open_mapping = [[<c-\>]],
        shading_factor = 2,
        direction = "float",
        -- shell = vim.o.shell, -- "/usr/bin/fish",
        shell = "/usr/bin/fish",
        float_opts = {
          border = "curved",
          highlights = { border = "Normal", background = "Normal" },
        },
      },
      vim.keymap.set(
        "n",
        "<leader>tf",
        "<cmd>ToggleTerm size=40 dir=cwd direction=float<cr>",
        { desc = "Open floating terminal" }
      ),
    })
  end,
  event = "BufEnter",
}
