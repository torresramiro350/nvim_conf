return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			-- define the sources
			timeout = 2000,
			sources = {
				null_ls.builtins.formatting.prettierd.with({
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "yaml" },
				}),
				null_ls.builtins.formatting.markdownlint.with({
					filetypes = { "markdown" },
				}),
				-- lua
				null_ls.builtins.formatting.stylua.with({
					filetypes = { "lua" },
				}),
				-- python
				null_ls.builtins.diagnostics.ruff.with({
					filetypes = { "python" },
				}),
				null_ls.builtins.formatting.ruff.with({
					filetypes = { "python" },
				}),
				null_ls.builtins.formatting.isort.with({
					filetypes = { "python" },
				}),
				-- null_ls.builtins.diagnostics.pylint.with({
				-- 	filetypes = { "python" },
				-- }),
				-- c++
				null_ls.builtins.formatting.clang_format.with({
					filetypes = { "c", "cpp", "cs", "cuda" },
				}),

				null_ls.builtins.formatting.cmake_format.with({
					filetypes = { "cmake" },
				}),
				-- rust
				null_ls.builtins.formatting.rustfmt,
				--bash
				null_ls.builtins.code_actions.shellcheck.with({
					filetypes = { "sh", "bash", "zsh" },
				}),
				null_ls.builtins.formatting.shfmt.with({
					filetypes = { "sh", "bash", "zsh" },
				}),
				-- latex
				null_ls.builtins.formatting.latexindent.with({
					filetypes = { "tex", "bib" },
				}),
				null_ls.builtins.diagnostics.vale.with({
					filetypes = { "tex", "bib" },
				}),
				-- TOML
				null_ls.builtins.formatting.taplo.with({
					filetypes = { "toml" },
					exclude_filetypes = { "lua" },
				}),
			},
		})
	end,
	-- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" }),
	requires = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
}
