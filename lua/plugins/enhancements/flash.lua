return {
  "folke/flash.nvim",
  as = "flash",
  -- event = { "BufReadPre", "BufNewFile", "InsertEnter" },
  event = { "InsertEnter", "BufReadPre", "BufReadPost", "BufNewFile" },
  -- @type Flash.Config
  opts = {
    modes = {
      char = {
        jump_labels = true,
      },
    },
    label = {
      uppercase = true,
      rainbow = {
        enabled = true,
        shade = 3,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "s[",    mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
