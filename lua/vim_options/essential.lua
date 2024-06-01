-- [[ Setting options ]]
-- nerd fonts
vim.g.have_nerd_font = true
-- copilot settings
vim.g.copilot_no_tab_map = false
-- Place all the general Neovim options
vim.g.gitblame_display_virtual_text = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.background = "dark"

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
-- draw the status line over the whole window
vim.opt.laststatus = 3

-- Place a column line
-- vim.opt.colorcolumn = "99"

-- Enable cursor line highlight
vim.opt.cursorline = true

-- set tabs to 2 spaces
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- set smart indent and set to 2 spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true
vim.o.relativenumber = true

-- Make line numbers default
vim.wo.number = true

vim.o.mousemoveevent = true
-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
