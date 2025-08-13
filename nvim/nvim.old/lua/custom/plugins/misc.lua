return {
	{
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"Bekaboo/deadcolumn.nvim",
		config = function()
			local opts = {
				scope = "line", ---@type string|fun(): integer
				---@type string[]|fun(mode: string): boolean
				modes = function(mode)
					return mode:find("^[ictRss\x13]") ~= nil
				end,
				warning = {
					alpha = 0.4,
					offset = 0,
					colorcode = "#000B12",
					hlgroup = { "Error", "bg" },
				},
			}

			require("deadcolumn").setup(opts) -- Call the setup function
		end,
	},
}
