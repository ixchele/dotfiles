return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("custom.whichkey")
		require("which-key").setup({
			win = {
				border = "single",
			},
		})
		require("which-key").add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "[H]arpoon", mode = "n" },
		})
	end,
}
