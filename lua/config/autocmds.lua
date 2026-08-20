-- local augroup = vim.api.nvim_create_augroup
require("groups.utility_funcs")
local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- autocmd("FileType", {
-- 	pattern = "make",
-- 	callback = function()
-- 		vim.lsp.start({
-- 			name = "makefile-lsp",
-- 			cmd = { "makefile-lsp" },
-- 		})
-- 	end,
-- })

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- resize split if window got resized
autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- highlight yanked text
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

--  disable inlay hints in insert mode
autocmd("InsertEnter", {
	callback = function()
		vim.lsp.inlay_hint.enable(false)
	end,
})

autocmd("InsertLeave", {
	callback = function()
		vim.lsp.inlay_hint.enable(true)
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local line_count = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
			-- defer centering slightly so it's applied render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- open help in vertical split
autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- make it easier to close man-files when opened inline
autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- enable cursor line only in active window enable
-- autocmd({ "WinEnter", "BufEnter" }, {
-- 	group = augroup("active_cursorline"),
-- 	callback = function()
-- 		vim.opt_local.cursorline = true
-- 	end,
-- })

-- show cursorline only in active window disable
-- autocmd({ "WinLeave", "BufLeave" }, {
-- 	group = "active_cursorline",
-- 	callback = function()
-- 		vim.opt_local.cursorline = false
-- 	end,
-- })

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		-- support both new and old versions of neovim
		local uv = vim.uv or vim.loop
		local file = uv.fs_realpath and uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- toggle formatting
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true
		vim.notify("Formatting disabled for this buffer")
	else
		vim.g.disable_autoformat = true
		vim.notify("Formatting disabled globally")
	end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
	vim.notify("Formatting re-enabled")
end, { desc = "Re-enable autoformat-on-save" })

vim.api.nvim_create_user_command("FormatToggle", function(args)
	local buf_state = vim.b.disable_autoformat
	local global_state = vim.g.disable_autoformat
	local is_disabled = buf_state or global_state

	if is_disabled then
		vim.cmd("FormatEnable")
	else
		if args.bang then
			vim.cmd("FormatDisable!")
		else
			vim.cmd("FormatDisable")
		end
	end
end, { desc = "Toggle autoformat-on-save", bang = true })

-- LSP
local completion = vim.g.completion_mode or "blink" or "native"
autocmd("LspAttach", {
	group = augroup("UserLspConfig"),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		-- NOTE: Disable hover in favor of pyright/basedpyright
		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end

		if client then
			-- Built-in completion
			if completion == "native" and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end

			-- Inlay hints
			if client:supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			end

			-- diagnostic
			local function diagnostic_goto(direction, severity)
				return function()
					vim.diagnostic.jump({
						severity = vim.diagnostic.severity[severity],
						count = direction and 1 or -1,
						float = true,
					})
				end
			end
			-- code actions
			Snacks.keymap.set(
				"n",
				"<leader>cc",
				vim.lsp.codelens.run,
				{ desc = "Run Codelens", lsp = { method = "textDocument/codeLens" } }
			)
			Snacks.keymap.set("n", "<leader>cC", function()
				return vim.lsp.codelens.enable(true)
			end, { desc = "Run Codelens", lsp = { method = "textDocument/codeLens" } })
			Snacks.keymap.set(
				"n",
				"K",
				vim.lsp.buf.hover,
				{ desc = "Documentation", lsp = { method = "textDocument/hover" } }
			)
			Snacks.keymap.set(
				"n",
				"gK",
				vim.lsp.buf.signature_help,
				{ desc = "Signature Documentation", lsp = { method = "textDocument/signatureHelp" } }
			)
			Snacks.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code Rename" })
			Snacks.keymap.set("n", "<leader>rs", "<cmd>lsp restart<cr>", { desc = "Restart server" })
			Snacks.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
				lsp = { method = "textDocument/codeAction" },
				desc = "Code Action",
			})
			Snacks.keymap.set("n", "<leader>co", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports" },
						diagnostics = {},
					},
				})
			end, { desc = "Organize imports" })
			Snacks.keymap.set(
				{ "n", "x" },
				"<leader>uF",
				"<cmd>FormatToggle<cr>",
				{ desc = "Toggle formatting globally" }
			)
			Snacks.keymap.set(
				{ "n", "x" },
				"<leader>uf",
				"<cmd>FormatToggle!<cr>",
				{ desc = "Toggle formatting for current buffer" }
			)
			Snacks.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Go to previous diagnostic message" })
			Snacks.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Go to next diagnostic message" })
			Snacks.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Go to previous error" })
			Snacks.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Go to next error" })
			Snacks.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Go to previous warning" })
			Snacks.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Go to next warning" })
			Snacks.keymap.set("n", "]Q", vim.cmd.clast, { desc = "End of quickfix list" })
			Snacks.keymap.set("n", "[Q", vim.cmd.cfirst, { desc = "Beginning of quickfix list" })
			Snacks.keymap.set("n", "[l", vim.cmd.lnext, { desc = "Next loclist" })
			Snacks.keymap.set("n", "]l", vim.cmd.lprev, { desc = "Previous loclist" })
			Snacks.keymap.set("n", "]L", vim.cmd.llast, { desc = "End of loclist" })
			Snacks.keymap.set("n", "[L", vim.cmd.lfirst, { desc = "Beginning of loclist" })
			Snacks.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
			Snacks.keymap.set("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Open location list" })
			Snacks.keymap.set("n", "<leader>xq", vim.diagnostic.setqflist, { desc = "Open quickfix list" })
			Snacks.keymap.set("n", "<leader>Q", "<cmd>cclose<cr>", { desc = "Close quickfix list" })
			Snacks.keymap.set("n", "<leader>L", "<cmd>lclose<cr>", { desc = "Close location list" })
		end
	end,
})
