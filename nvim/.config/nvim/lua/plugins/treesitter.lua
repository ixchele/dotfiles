return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "c", "cpp", "lua", "python", "vim", "vimdoc" },
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true }
	},
}
