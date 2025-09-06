return {
	{
		"shaunsingh/nord.nvim",
		-- priority = 1000,
		config = function()
			vim.cmd.colorscheme("nord")
		end,
	},
	-- {
	-- 	'ray-x/aurora',
	-- 	init = function()
	-- 		vim.g.aurora_italic = 1
	-- 		vim.g.aurora_transparent = 1
	-- 		vim.g.aurora_bold = 1
	-- 	end,
	-- 	config = function()
	-- 		-- vim.cmd.colorscheme "aurora"
	-- 		-- vim.api.nvim_set_hl(0, '@number', { fg = '#e933e3' })
	-- 	end
	-- },
	-- {
	-- 	"bluz71/vim-nightfly-colors",
	-- 	name = "nightfly",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme "nightfly"
	-- 		local colors = require("nightfly").palette
	-- 		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
	-- 			fg = colors.watermelon,
	-- 			bg = colors.black_blue,
	-- 			italic = true,
	-- 		})
	-- 		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
	-- 			fg = colors.grey,
	-- 			italic = true,
	-- 		})
	-- 	end
	-- },
	--
}
