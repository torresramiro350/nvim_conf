return {
  "hrsh7th/cmp-cmdline",
  -- config = function() end,
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  -- event = "BufReadPre",
  event = "CmdLineEnter",
}
