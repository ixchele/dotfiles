return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope_ok, telescope = pcall(require, "telescope")
		if not telescope_ok then
			return
		end

		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				initial_mode = "normal",
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			extensions = {
				fzf = {},
			},
		})

		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")
		local map = vim.keymap.set

		local themed_picker = function(picker, theme, params)
			return function()
				local opts = themes[theme](params)
				builtin[picker](opts)
			end
		end

		map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		map("n", "<leader>sm", themed_picker("man_pages", "get_ivy", {
			initial_mode = "insert",
			sections = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
			winblend = 10,
			previewer = true,
			layout_config = { width = 170, height = 25 },
		}), { desc = "[S]earch [M]an pages" })

		map("n", "<leader>/", themed_picker("current_buffer_fuzzy_find", "get_dropdown", {
			winblend = 10,
			previewer = false,
			layout_config = { width = 170, height = 25 },
		}), { desc = "[/] Search in current buffer" })

		map("n", "<leader>sk", themed_picker("keymaps", "get_dropdown", {
			winblend = 20,
			previewer = true,
			layout_config = { height = 30, width = 160 },
		}), { desc = "[S]earch [K]eymaps" })

		map("n", "<leader>sn", themed_picker("find_files", "get_ivy", {
			winblend = 20,
			prompt_title = "Neovim Config Files",
			cwd = vim.fn.stdpath("config"),
		}), { desc = "[S]earch [N]vim Config" })

		map("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		map("n", "<leader>sp", function()
			builtin.find_files({
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
				prompt_title = "[S]earch [P]ackages",
			})
		end, { desc = "[S]earch Packages" })
	end,
}
