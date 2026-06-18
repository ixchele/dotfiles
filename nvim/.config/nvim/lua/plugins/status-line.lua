return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			theme = vim.g.colors_name,
			component_separators = { left = "╱", right = "╱" },
			section_separators = { left = "", right = "" },
			-- globalstatus = true,
			disabled_filetypes = {
				statusline = { 'TelescopePrompt', 'dashboard', "toggleterm" },
			}
		},
		sections = {
			lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{ "filename", file_status = true, path = 1 },
				{
					function()
						return "recording @" .. vim.fn.reg_recording()
					end,
					cond = function()
						return vim.fn.reg_recording() ~= ""
					end,

					color = "DiagnosticWarn",
				},
			},
			lualine_x = { "encoding",  "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },

		},
	},
}
