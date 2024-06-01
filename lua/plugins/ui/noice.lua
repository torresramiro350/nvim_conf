return {
  "folke/noice.nvim",
  -- event = "CmdlineEnter",
  event = "UIEnter",
  -- event = "VimEnter",
  priority = 1000,
  config = function()
    local nmap = function(mode, keys, func, additional_args)
      additional_args = additional_args or {}
      vim.keymap.set(mode, keys, func, additional_args)
    end
    local noice = require("noice")

    noice.setup({
      lsp = {
        override = {
          ["cmp.entry.get_documentation"] = true,
        },
        presets = {
          lsp_doc_border = true,
        },
      },
    })
    nmap("c", "<S-Enter>", function()
      noice.redirective(vim.fn.getcmdline())
    end, { desc = "Redirect cmdline" })

    nmap({ "n", "i", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true })

    nmap({ "n", "i", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true })
  end,

  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}
