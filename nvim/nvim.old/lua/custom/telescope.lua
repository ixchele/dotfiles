-- TODO: See `:help telescope` and `:help telescope.setup()`

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = {
			-- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			i = {
				["<C-s>"] = actions.cycle_previewers_next,
				["<C-a>"] = actions.cycle_previewers_prev,
			},
		},
	},
	-- pickers = {}
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- TODO: See `:help telescope.builtin`
local builtin = require("telescope.builtin")
local map = vim.keymap.set
map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
-- map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- TODO: See `:help telescope.layout`
map("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
		layout_config = {
			width = 170,
		},
	}))
end, { desc = "[/] Search in current buffer" })

map("n", "<leader>sk", function()
	builtin.keymaps(require("telescope.themes").get_dropdown({
		winblend = 20,
		previewer = true,
		layout_config = {
			height = 30,
			width = 160,
		},
	}))
end, { desc = "[S]earch [K]eymaps" })

--  TODO: See `:help telescope.builtin.live_grep()` for information about particular keys
map("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

map("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
