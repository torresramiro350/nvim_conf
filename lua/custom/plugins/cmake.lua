return {
  'Civitasv/cmake-tools.nvim',
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake"
    })
  end,
  lazy = true,
  event = { "BufEnter *.c", "BufEnter *.cpp", "BufEnter *.cxx", "BufEnter CMake*" }
}
