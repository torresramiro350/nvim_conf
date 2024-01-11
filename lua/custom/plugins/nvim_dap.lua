return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local dap_python = require("dap-python")
    dap_python.setup("/home/rtorres/miniforge3/envs/hal_310/bin/python")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    -- stylua: ignore
    vim.keymap.set("n", "<Leader>dt", function() dap.toggle_breakpoint() end, { desc = "Toggle break point" })
    -- stylua: ignore
    vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Continue debugging" })
  end,
  event = "VeryLazy",
}
