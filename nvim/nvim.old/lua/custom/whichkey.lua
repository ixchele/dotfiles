require("which-key").setup({
	win = {
		border = "single",
	},
})
require("which-key").add({
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>d", group = "[D]ocument" },
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>h", group = "[H]arpoon", mode = "n" },
})
