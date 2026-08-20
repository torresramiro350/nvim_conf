local opt = vim.opt
local wo = vim.wo

-- nerd fonts
vim.g.have_nerd_font = true
vim.g.completion_mode = "blink" -- set default completion mode
vim.g.use_blink_cmp_main = false

-- Basic settings
opt.exrc = true -- enables project local configurations
opt.wrap = false -- no wrapping of code
opt.viewoptions = { "cursor", "folds" } -- keep the viewoption in cursot's last location
opt.number = true -- display line number
opt.cursorline = true -- highlight current line
opt.relativenumber = true -- relative numbers
opt.scrolloff = 10 -- keep 10 lines above/below cursor
opt.sidescrolloff = 8 -- keep 8 columns left/right of cursor
opt.ruler = false -- Disable the default ruler
-- TODO: find what this oes
opt.laststatus = 3 -- draw the status line over the whole window
opt.textwidth = 100 -- set the maximum text width to be 80 characters
opt.wildmode = "longest:full,full" -- completion mode for the command line
opt.wildignorecase = true -- case-insentive tab completion in commands
opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block
opt.winminwidth = 5 -- minimum window width

-- Indentation
opt.shiftround = true -- round indent
opt.tabstop = 2 -- tab width
opt.shiftwidth = 2 -- indent width
opt.softtabstop = 2 -- soft tab stop
opt.expandtab = true -- use spaces instead of tabs
opt.smartindent = true -- smart auto-indenting
opt.autoindent = true -- copy indent from current line
opt.breakindent = true -- Enable break indent
opt.signcolumn = "yes" -- Always show sign column, otherwise it would shift the text each time
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.list = true -- show some invisible characters
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Search settings
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive if uppercase search
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Show matches as you type
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m" -- filename, line number, colon, content

-- Visual settings
opt.termguicolors = true -- Enable 24-bit colors
opt.colorcolumn = "100" -- Show column at 90 characters
opt.showmatch = true -- Highlight matching parenthesis
opt.matchtime = 2 -- How long to show matching bracket
opt.cmdheight = 1 -- Command line height
-- refer to complete options: https://neovim.io/doc/user/options.html#'completeopt'
opt.completeopt = "menu,menuone,noselect,fuzzy" -- Completion options
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Pop-up menu height
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 0 -- Floating window transparency
opt.conceallevel = 2 -- Don't hide markup
opt.concealcursor = "" -- Don't hide curser line markup
opt.lazyredraw = false -- Don't redraw during macros (false to work with noice)
opt.synmaxcol = 300 -- Syntax highlight limit
-- TODO: find what this oes
opt.jumpoptions = "view"
opt.inccommand = "nosplit" -- preview incremental substitute

-- File handling
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.updatetime = 300 -- Faster compeltion
opt.timeoutlen = 500 -- Key timeout duration
opt.ttimeoutlen = 0 -- Key code timeout
opt.autoread = true -- Auto relaod files changed outside vim
opt.autowrite = false -- Don't autosave on some events
opt.diffopt:append("vertical") -- vertical diff splits
opt.diffopt:append("algorithm:patience") -- better diff algorithm
opt.diffopt:append("linematch:60") -- better diff highlighting (smart line matching)

-- Undo directory
local undodir = "~/.local/share/nvim/undodir" -- undo directory path
opt.undodir = vim.fn.expand(undodir)
local undodir_path = vim.fn.expand(undodir) -- expand full path
if vim.fn.isdirectory(undodir_path) == 0 then
	vim.fn.mkdir(undodir_path, "p") -- create it, if it doens't exist
end
-- opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory

-- Behavior settings
opt.hidden = true -- Allow hidden buffers
opt.errorbells = false -- No error bells
opt.backspace = "indent,eol,start" -- Better backspace behavior
opt.autochdir = false -- Don't auto change directory
opt.iskeyword:append("-") -- Treat dash as part of word
opt.path:append("**") -- include subdirectories in search
opt.selection = "inclusive" -- use inclusive selection
opt.mouse = "a" -- Enable mouse support
opt.mousemoveevent = true
opt.clipboard:append("unnamedplus") -- Use system clipboard
opt.modifiable = true -- Allow buffer modifications
opt.encoding = "UTF-8" -- Set encoding

-- Folding settings
opt.foldmethod = "expr" -- Use expression for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"

-- Split behavior
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
vim.opt.splitkeep = "screen" -- Better splitting

-- Key mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Place all the general Neovim options
vim.g.gitblame_display_virtual_text = 1
-- vim.o.background = "auto"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Session handling
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
