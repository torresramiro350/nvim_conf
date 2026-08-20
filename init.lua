-- load in the general options to use with vim
require("config.options")
-- Load lazyvim's configuration
require("config.lazy")
-- load all general mappings
require("keymaps.mappings")
-- load my autocmds
require("config.autocmds")
-- load the lsp diagnostics configuration
require("lsp.lsp")
-- require("utils.diagnostics")
