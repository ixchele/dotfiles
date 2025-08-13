function _G.get_oil_winbar()
	local dir = require("oil").get_current_dir()
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		return vim.api.nvim_buf_get_name(0)
	end
end

require("oil").setup({
	columns = { { "icon", add_padding = false } },
	prompt_save_on_select_new_entry = false,
	keymaps = {
		["<C-h>"] = false,
		["<C-l>"] = false,
		["<C-s>"] = false,
		["<leader><C-s>"] = {
			"actions.select",
			opts = { vertical = true },
			desc = "Open the entry in a vertical split",
		},
		["<leader><C-h>"] = {
			"actions.select",
			opts = { horizontal = true },
			desc = "Open the entry in a horizontal split",
		},
		["<leader><C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
	},
	view_options = {
		show_hidden = true,
	},
	constrain_cursor = "editable",
	watch_for_changes = true,
	win_options = {
		winbar = "%!v:lua.get_oil_winbar()",
	},
	float = {
		padding = 8,
		width = 190,
		height = 120,
		border = "single",
		win_options = {
			winblend = 15,
		},
		preview_split = "left",
	},
})
-- Open Explorer

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Explorer" })
vim.keymap.set("n", "<leader>--", require("oil").toggle_float)
vim.keymap.set("n", "<leader>--", require("oil").toggle_float)
