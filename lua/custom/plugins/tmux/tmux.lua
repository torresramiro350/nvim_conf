return {
  event = "VimEnter",
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>",  ":TmuxNavigateLeft<CR>" },
    { "<c-j>",  ":TmuxNavigateDown<CR>" },
    { "<c-k>",  ":TmuxNavigateUp<CR>" },
    { "<c-l>",  ":TmuxNavigateRight<CR>" },
    { "<c-\\>", ":TmuxNavigatePrevious<CR>" },
  },
}
