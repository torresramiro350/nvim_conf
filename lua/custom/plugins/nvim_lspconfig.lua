return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim",                   opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
  },
  config = function()
    --import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Lesser used LSP functionality
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
      nmap("<leader>lf", "<cmd>Format<cr>", "[L]format")
    end

    local ruff_attach = function(client, bufnr)
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
      -- client.server._capabilities.hoverProvider = false
    end

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- julia
    require("lspconfig").julials.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.rust_analyzer.setup({
      -- capabilities = {
      --   offsetEncoding = "utf-16"
      -- },
      capabilities = capabilities,
      on_attach = on_attach,
      -- settings = {
      --   ['rust-analyzer'] = {
      --     diagnostics = {
      --       enabled = false
      --     }
      --   }
      -- }
      filetypes = { "rust" },
    })

    lspconfig.texlab.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "tex", "plaintex", "bib" },
    })

    lspconfig.ruff_lsp.setup({
      capabilities = capabilities,
      on_attach = ruff_attach,
      filetypes = { "python" },
    })

    -- configure python server
    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      -- settings = {
      --   single_filesupport=false,
      -- }
    })

    lspconfig.bashls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "sh" },
    })

    lspconfig.cmake.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        buildDirectory = "build",
      },
      filetypes = "cmake",
    })

    lspconfig.yamlls.setup({
      capabilities = capabilities, -- this line is required for nvim-cmp to work with nvim-lsp
      on_attach = on_attach,
    })

    lspconfig.marksman.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.clangd.setup({
      require("clangd_extensions.inlay_hints").setup_autocmd(),
      require("clangd_extensions.inlay_hints").set_inlay_hints(),
      capabilities = {
        capabilities,
        offsetEncoding = "utf-8",
      },
      init_options = {
        usePlaceholders = true,
        completeunimported = true,
        clangdFileStatus = true,
      },
      -- on_attach = on_attach,
      on_attach = on_attach,
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    -- autoformat.lua
    --
    -- Use your language server to automatically format your code on save.
    -- Adds additional commands as well to manage the behavior
    local format_is_enabled = true
    vim.api.nvim_create_user_command("KickstartFormatToggle", function()
      format_is_enabled = not format_is_enabled
      print("Setting autoformatting to: " .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = "kickstart-lsp-format-" .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format({
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            })
          end,
        })
      end,
    })
  end,
  event = { "BufReadPre", "BufNewFile" },
}
