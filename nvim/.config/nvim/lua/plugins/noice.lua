return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				enabled = true,
				view = "hover",
				opts = {
					border = {
						style = "rounded",
					},
					position = { row = 2, col = 2 },
				},
			},
		},
		views = {
			hover = {
				relative = "cursor",
				position = {
					row = 2,
					col = 2,
				},

				size = {
					max_width = 70,
					max_height = 20,
				},
				border = {
					style = "rounded",
				},
			},
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
		},
		routes = {
			{
				filter = {
					event = "lsp",
					kind = "progress",
				},
				opts = { skip = true },
			},
		},
	},
}
