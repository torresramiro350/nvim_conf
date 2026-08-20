return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = { "BufNewFile", "BufRead" },
	command = { "ConformInfo" },
	opts = function()
		local opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			-- format_on_save = { lsp_format = "fallback" },
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { lsp_format = "fallback" }
			end,
			formatters = {
				["markdown-toc"] = {
					condition = function(_, ctx)
						for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
							if line:find("<!%-%- toc %-%->") then
								return true
							end
						end
					end,
				},
				["markdownlint-cli2"] = {
					condition = function(_, ctx)
						local diag = vim.tbl_filter(function(d)
							return d.source == "markdownlint"
						end, vim.diagnostic.get(ctx.buf))
						return #diag > 0
					end,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				yaml = { "yamlfmt" },
				json = { "prettierd", "prettier" },
				["markdown"] = { "rumdl", "markdown-toc" },
				["markdown.mdx"] = { "rumdl", "markdown-toc" },
				-- ["markdown"] = { "rumdl", "markdownlint-cli2", "markdown-toc" },
				-- ["markdown.mdx"] = { "rumdl", "markdownlint-cli2", "markdown-toc" },
				fish = { "fish_indent" },
				makefile = { "bake" },
				cmake = { "cmake_format", "gersemi" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				sh = { "shellharden", "shfmt" },
				toml = { "taplo" },
				tex = { "latexindent" },
				typst = { "typstyle", "prettypst" },
			},
		}
		return opts
	end,
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
