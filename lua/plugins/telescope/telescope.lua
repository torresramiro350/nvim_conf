-- import utility function to define keymaps
require("groups.utility_funcs")
-- Fuzzy Finder (files, lsp, etc)
return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "crispgm/telescope-heading.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function() end,
  },
  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter", "UIEnter" },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local actions = require("telescope.actions")
      require("telescope").setup({
        extensions = {
          file_browser = {
            -- theme = "catppuccin",
          },
          heading = {
            treesitter = true,
            picker_opts = {
              layout_config = { width = 0.8, preview_width = 0.5 },
              layout_strategy = "horizontal",
            },
          },
        },
        defaults = {
          mappings = {
            -- add mappings in insert mode
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-j>"] = {
                actions.move_selection_next,
                type = "action",
              },
              ["<C-k>"] = {
                actions.move_selection_previous,
                type = "action",
              },
            },
            -- add mappings in normal mode
            n = {
              ["q"] = {
                actions.close,
                type = "action",
              },
              ["j"] = {
                actions.move_selection_next,
                type = "action",
              },
              ["k"] = {
                actions.move_selection_previous,
                type = "action",
              },
            },
          },
        },
      })

      -- utilify function to make defining keymaps easier
      -- local nmap = function(mode, keys, func, additional_args)
      -- 	additional_args = additional_args or {}
      -- 	vim.keymap.set(mode, keys, func, additional_args)
      -- end
      --
      -- Telescope live_grep in git root
      -- Function to find the git root directory based on the current buffer's path
      local function find_git_root()
        -- Use the current buffer's path as the starting point for the git search
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir
        local cwd = vim.fn.getcwd()
        -- If the buffer is not associated with a file, return nil
        if current_file == "" then
          current_dir = cwd
        else
          -- Extract the directory from the current file's path
          current_dir = vim.fn.fnamemodify(current_file, ":h")
        end

        -- Find the Git root directory from the current file's path
        local git_root =
            vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
        if vim.v.shell_error ~= 0 then
          print("Not a git repository. Searching on current working directory")
          return cwd
        end
        return git_root
      end

      -- mappings
      -- TELESCOPE
      local tel_bin = require("telescope.builtin")
      local tel = require("telescope")
      local tel_themes = require("telescope.themes")
      local heading = require("telescope").load_extension("heading")
      -- Enable telescope fzf native, if installed
      pcall(tel.load_extension, "fzf")

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          tel_bin.live_grep({ search_dirs = { git_root } })
        end
      end

      vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

      nmap("n", "<leader>?", tel_bin.oldfiles, { desc = "[?] Find recently opened files" })
      nmap("n", "<leader><space>", tel_bin.buffers, { desc = "[ ] Find existing buffers" })
      nmap("n", "<leader>/", function()
        tel_bin.current_buffer_fuzzy_find(tel_themes.get_dropdown({
          winblend = 10,
          previewer = true,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      nmap("n", "<leader>fb", tel.extensions.file_browser.file_browser, { desc = "File Browser", noremap = true })
      nmap("n", "<leader>sb", tel_bin.buffers, { desc = "[S]earch [B]uffer" })
      nmap("n", "<leader>gf", tel_bin.git_files, { desc = "Search [G]it [F]iles" })
      nmap("n", "<leader>sf", tel_bin.find_files, { desc = "[S]earch [F]iles" })
      nmap("n", "<leader>sh", tel_bin.help_tags, { desc = "[S]earch [H]elp" })
      nmap("n", "<leader>sw", tel_bin.grep_string, { desc = "[S]earch current [W]ord" })
      nmap("n", "<leader>sg", tel_bin.live_grep, { desc = "[S]earch by [G]rep" })
      nmap("n", "<leader>sd", tel_bin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      nmap("n", "<leader>sr", tel_bin.resume, { desc = "[S]earch [R]esume" })
      nmap("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
    end,
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        event = { "VimEnter", "UIEnter" },
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
  },
}
