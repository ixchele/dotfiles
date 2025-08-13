local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = " " }
opt.shiftwidth = 4
opt.tabstop = 4
opt.inccommand = "split"
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 10
opt.swapfile = false
opt.backup = false
opt.wrap = false
opt.sidescroll = 10
opt.list = true
opt.autowrite = true
opt.showmatch = true
opt.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,i:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175"
-- TODO: see :help colorcolumn
opt.colorcolumn = "80"
