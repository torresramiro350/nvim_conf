return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = { "BufRead", "BufNewFile" },
	-- enabled = true,
	enabled = false,
	keys = function()
		local ufo = require("ufo")
		local peek_under_cursor = function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end
		return {
			{ "n", "zR", ufo.openAllFolds, { desc = "Open all folds" } },
			{ "n", "zM", ufo.closeAllFolds, { desc = "Close all folds" } },
			{ "n", "zr", ufo.openFoldsExceptKinds, { desc = "Open all folds except kinds" } },
			{ "n", "zm", ufo.closeFoldsWith, { desc = "Close all folds with kinds" } },
			{ "n", "K", peek_under_cursor, { desc = "Peek folded lines under cursor" } },
		}
	end,
	opts = function()
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" 󰁂 %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end
		return {
			fold_virt_text_handler = handler,
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		}
	end,
	config = function(_, opts)
		local ufo = require("ufo")
		ufo.setup(opts)
	end,
}
