require("config.opts")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
require("config.prototypes")
require("config.loadtobuff")
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99  -- pour que tout soit déplié au départ
