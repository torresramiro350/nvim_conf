return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-path",   -- source for file system paths
    "hrsh7th/cmp-buffer", -- source for text in buffer

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
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
    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end
    -- local luasnip = require("luasnip")

    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require("lspkind")
    local copilot = require("copilot.suggestion")
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- sorting = {
      --   comparators = {
      --     cmp.config.compare.offset,
      --     cmp.config.compare.exact,
      --     cmp.config.compare.recently_used,
      --     require("clangd_extensions.cmp_scores"),
      --     cmp.config.compare.kind,
      --     cmp.config.compare.sort_text,
      --     cmp.config.compare.length,
      --     cmp.config.compare.order,
      --   },
      -- },
      completion = {
        completeopt = 'menu,menuone,noinsert'
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if copilot.is_visible() then
            copilot.accept()
          elseif cmp.visible() and has_words_before() then
            -- necessary for usage with Copilot
            -- so that it doesn't interfere with cmp or lsp completion suggestions
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            -- cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "buffer" },
        { name = 'luasnip' },
        { name = 'copilot' },
        { name = "path" },
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {

        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = { Copilot = " " }
        }),
      },
    }
  end,
}
