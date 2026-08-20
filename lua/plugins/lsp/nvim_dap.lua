return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufReadPost" },
	enabled = true,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		{
			"rcarriga/nvim-dap-ui",
			keys = {
        -- stylua: ignore start
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
				-- stylua: ignore end
			},
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
		},
		{
			"mfussenegger/nvim-dap-python",
			ft = "python",
			config = function()
				local dap_python = require("dap-python")
				dap_python.setup("uv")
			end,
			keys = {
		    -- stylua: ignore start
		    { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
		    { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
				-- stylua: ignore end
			},
		},
	},
	config = function()
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
		local dap = require("dap")
		local dapui = require("dapui")
		if not dap.adapters["codelldb"] then
			require("dap").adapters["codelldb"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = {
						"--port",
						"${port}",
					},
				},
			}
		end

		for _, lang in ipairs({ "c", "cpp" }) do
			dap.configurations[lang] = {
				{
					type = "codelldb",
					request = "launch",
					name = "Launch file",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end

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
	end,
	keys = {
    -- stylua: ignore start
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		-- stylua: ignore end
	},
}
