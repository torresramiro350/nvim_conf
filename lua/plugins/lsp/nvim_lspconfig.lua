return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  -- event = { "BufReadPre", "BufReadPost", "BufNewFile" },
  event = { "InsertEnter", "BufReadPre", "BufReadPost", "BufNewFile" },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({})
      end,
      event = "VeryLazy",
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          -- ensure_installed = {}
        })
      end,
    },
    { "antosha417/nvim-lsp-file-operations", config = true },

    -- Useful status updates for LSP
    {
      "j-hui/fidget.nvim",
      dependencies = {
        {
          "folke/neodev.nvim",
          event = "VeryLazy",
          -- event = "BufRead *.lua",
        },
      },
      event = { "BufReadPre", "BufReadPost", "BufNewFile" },
      config = function()
        require("fidget").setup({
          progress = {
            suppress_on_insert = true,
            ignore_done_already = true,
          },
          notification = {
            window = {
              winblend = 0,
            },
          },
        })
      end,
    },

    -- -- Additional lua configuration, makes nvim stuff amazing!
    -- "folke/neodev.nvim",
  },
  config = function()
    --import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
      -- declared here to avoid the automatic enabling of nvim-navic which raises
      -- a warning for rust
      if client.server_capabilities["documentSymbolProvider"] then
        require("nvim-navic").attach(client, bufnr)
      end

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
      nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

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
    -- lspconfig.julials.setup({
    --   capabilities = capabilities,
    --   filetypes = { "julia" },
    --   on_attach = on_attach,
    -- })

    --latex
    lspconfig.texlab.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "tex", "plaintex", "bib" },
      settings = {
        texlab = {
          build = {
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
            executable = "latexmk",
            forwardSearchAfter = false,
            onSave = false,
          },
          chktex = {
            onEdit = false,
            onOpenAndSave = false,
          },
          diagnosticsDelay = 300,
          forwardSearch = {
            args = {},
          },
          formatterLineLength = 80,
          bibtexFormatter = "texlab",
          latexFormatter = "latexindent",
          latexindent = {
            modifyLineBreaks = false,
          },
        },
      },
    })

    -- configure python server
    -- NOTE: only available for free with open source projects (hope to use
    -- it in the future)

    local sourcery_file = io.open(vim.fn.expand("~/.config/nvim/sourcery_token.txt"), "r")
    if sourcery_file then
      MYTOKEN = sourcery_file:read("*line")
      sourcery_file.close()
    else
      print("No sourcery file found")
    end

    lspconfig.sourcery.setup({
      capabilities = capabilities,
      on_attach = ruff_attach,
      init_options = {
        token = MYTOKEN,
        editor_version = "vim",
      },
      filetypes = { "python" },
      cmd = { "sourcery", "lsp" },
      single_file_support = true,
    })

    -- lspconfig.ruff_lsp.setup({
    --   capabilities = capabilities,
    --   on_attach = ruff_attach,
    --   filetypes = { "python" },
    -- })

    lspconfig.ruff.setup({
      cmd = { "ruff", "server", "--preview" },
      filetypes = { "python" },
      capabilities = capabilities,
      on_attach = ruff_attach,
    })

    lspconfig.pyright.setup({
      cmd = { "pyright-langserver", "--stdio" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
          },
        },
      },
      single_file_support = true,
    })

    -- require("lspconfig").pylyzer.setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   single_file_support = true,
    --   settings = {
    --     python = {
    --       checkOnType = false,
    --       diagnostics = true,
    --       inlayHints = true,
    --       smartCompletion = true,
    --     },
    --   },
    -- })

    --bash
    lspconfig.bashls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "sh" },
    })

    -- cmake
    lspconfig.cmake.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        buildDirectory = "build",
      },
      filetypes = "cmake",
    })

    -- YAML
    lspconfig.yamlls.setup({
      capabilities = capabilities, -- this line is required for nvim-cmp to work with nvim-lsp
      on_attach = on_attach,
    })

    -- markdown
    lspconfig.marksman.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- C/C++
    lspconfig.clangd.setup({
      capabilities = {
        capabilities,
        offsetEncoding = "utf-8",
      },
      init_options = {
        usePlaceholders = true,
        completeunimported = true,
        clangdFileStatus = true,
      },
      on_attach = on_attach,
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    })

    -- Lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      filetypes = { "lua" },
      cmd = { "lua-language-server" },
      single_file_support = true,
    })

    -- TOML
    lspconfig.taplo.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "toml" },
    })

    -- add more server configurations below

    -- autoformat.lua
    --
    -- Use your language server to automatically format your code on save.
    -- Adds additional commands as well to manage the behavior
    local format_is_enabled = true
    vim.api.nvim_create_user_command("FormatToggle", function()
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
}
