return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  enabled = true,
  config = function()
    local lualine = require("lualine")

    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        lualine.refresh({
          place = { "statusline" },
        })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
    })

    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "Recording @" .. recording_register
      end
    end

    local function client_lsp()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.buf_get_clients(bufnr)
      if next(clients) == nil then
        return ""
      end

      local c = {}
      for _, client in ipairs(clients) do
        if client.name == "null-ls" or client.name == "GitHub Copilot" then
          -- Hide null-ls and GitHub Copilot
          -- skip these entries into the table of clients
          goto continue
        end
        table.insert(c, client.name)
        ::continue::
      end
      return table.concat(c, "  ")
    end

    -- Color table for highlights
    -- stylua: ignore
    lualine.setup({
      options = {
        -- theme = "auto",
        theme = "catppuccin",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
      },
      sections = {

        lualine_b = { {
          'buffers',
          max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
          -- it can also be a function that returns
          -- the value of `max_length` dynamically.
        }, 'branch', {
          'diff',
          symbols = { added = '+', modified = '~', removed = '-' },
        }, {
          'diagnostics',
          sections = { 'error', 'warn', 'info', 'hint' },
          sources = { 'nvim_lsp', 'nvim_diagnostic' }
        }, },
        lualine_c = { 'filename', {
          "macro-recording",
          fmt = show_macro_recording,
        },
          client_lsp }

        -- lualine_x = {'filename'}
      }
    })
  end,
}
