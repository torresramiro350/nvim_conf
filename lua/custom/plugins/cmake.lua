return {
  "Civitasv/cmake-tools.nvim",
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake",
    })
  end,
  ft = { "cmake" },
  -- event = { "BufEnter CMake*" },
}
