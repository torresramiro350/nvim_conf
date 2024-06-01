return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	-- event = "InsertEnter",
	event = { "InsertEnter", "BufReadPre", "BufReadPost", "BufNewFile" },
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-buffer", -- source for text in buffer

		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
		-- vs-code like picograms
		"onsails/lspkind.nvim",
	},

	config = function()
		-- Unlike other completion sources, copilot can use other lines above or below an
		-- empty line to provide a completion. This can cause problematic for individuals
		-- that select menu entries with <TAB>. This behavior is configurable via cmp's
		-- config and the following code will make it so that the menu still appears
		-- normally, but tab will fallback to indenting unless a non-whitespace character
		-- has actually been typed.
		--
		-- local has_words_before = function()
		-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		-- 		return false
		-- 	end
		-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		-- 	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
		-- end
		local function has_words_before()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		-- [[ Configure nvim-cmp ]]
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		-- local copilot = require("copilot.suggestion")
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})

		-- sets up auto completion for the command line
		cmp.setup.cmdline({ "/", "?" }, {
			-- mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			-- mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		cmp.setup({
			-- setup the window style for code completion (I like the window rounded style)
			-- with borders for both code completion and documentation
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			-- setup snopped completions
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- will update this with more information once I know what this is doing
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.exact,
					-- require("copilot_cmp.comparators").prioritize,
					cmp.config.compare.offset,
					cmp.config.compare.recently_used,
					-- require("clangd_extensions.cmp_scores"),
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
				-- rounded style (my preference)
				border = "rounded",
			},
			-- setup some keybindings for the selection of code completions
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<CR>"] = cmp.mapping.confirm({
					-- behavior = cmp.ConfirmBehavior.Replace,
					-- select = true,
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- elseif cmp.visible() then
						-- necessary for usage with Copilot
						-- so that it doesn't interfere with cmp or lsp completion suggestions
						if #cmp.get_entries() == 1 then
							cmp.confirm({ select = true })
						else
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						end
					-- elseif luasnip.expand_or_locally_jumpable() then
					--   luasnip.expand_or_jump()
					-- little addition to introduce copilot's code completions
					elseif has_words_before() then
						cmp.complete()
						if #cmp.get_entries() == 1 then
							cmp.confirm({ select = true })
						end
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- source completion list
			sources = cmp.config.sources({
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "buffer", group_index = 2 },
				{ name = "luasnip", group_index = 2 },
				{ name = "path", group_index = 2 },
				-- { name = "copilot",  group_index = 2 },
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
					-- symbol_map = { Copilot = " " },
				}),
			},
		})
	end,
}
