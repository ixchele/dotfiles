require("config")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight yank", {clear = true}),
	callback = function ()
		vim.highlight.on_yank()
	end

})

vim.cmd.highlight "EndOfBuffer guibg=NONE guifg=bg"
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.cmd('filetype plugin on')
vim.cmd('runtime! plugin/man.vim')

-- vim.cmd.highlight "EndOfBuffer ctermbg=NONE guibg=NONE guifg=bg ctermfg=bg"
