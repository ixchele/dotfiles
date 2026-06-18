-- ~/.config/nvim/lua/config/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymaps = require("which-key").add

keymaps({
	{
		mode = "n",
		{
			"<Esc>",
			function()
				vim.cmd.nohlsearch()
				if package.loaded["noice"] then require("noice").cmd("dismiss") end
			end,
			desc = "Clear search & notifications",
		},

		{ "-", ":Oil --float<CR>", desc = "Open Oil floating file explorer" },
		{ "gl", function() vim.diagnostic.open_float() end, desc = "Open diagnostics in float" },

		{ "<Enter>", "van", desc = "Treesitter: Init smart selection", remap = true},
		{ "<C-Up>", ":resize -2<CR>",  desc = "Resize window smaller vertically" },
		{ "<C-Down>", ":resize +2<CR>", desc = "Resize window larger vertically" },
		{ "<C-Left>", ":vertical resize -2<CR>", desc = "Resize window larger horizontally" },
		{ "<C-Right>", ":vertical resize +2<CR>", desc = "Resize window smaller horizontally" },
		{ "<S-l>", ":bnext<CR>",  desc = "Go to next buffer" },
		{ "<S-h>", ":bprevious<CR>",  desc = "Go to previous buffern" },
		{ "<C-d>", "<C-d>zz", desc = "Keep cursor in the middle of the screen when jumping down"},
		{ "<C-u>", "<C-u>zz", desc = "Keep cursor in the middle of the screen when jumping up" },
		{ "<leader>a", "ggVG", desc = "Select all file"},
		{ "<leader>%", "<cmd>source<cr>", desc = "Source current file" },


		{ "<leader>c", "<C-w>c", desc = "Close current window"},
		{ "<leader>Y", '"+Y', desc = "Copy line to system clipboard" },
		{ "<leader>P", '"+P', desc = "Past line from system clipboard" },
		{ "<leader>y", '"+y', desc = "Copy to system clipboard" },
		{ "<leader>p", '"+p', desc = "Copy to system clipboard" },
		{ "<leader>d", '"_d', desc = "Delete without copying" },
		{ "<leader>w", ":w<CR>", desc = "Save file" },
		{ "<leader>q", ":q<CR>", desc = "Quit file" },
		{ "<leader>x", ":wq<CR>", desc = "Save and quit" },

		{ "<leader>s", group = "Split", icon = "" },
		{ "<leader>sv", ":vsplit<CR>", desc = "Split vertically" },
		{ "<leader>sh", ":split<CR>", desc = "Split horizontally" },

		{ "<leader>f", group = "Telescope", icon = " "},
		{ "<leader>ff", ":Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fg", ":Telescope live_grep<CR>", desc = "Live grep" },
		{ "<leader>fb", ":Telescope buffers<CR>", desc = "List buffers" },
		{ "<leader>fh", ":Telescope help_tags<CR>", desc = "Finde help tags" },
		{ "<leader>fs", ":Telescope builtin<CR>", desc = "[F]ind [S]elect Telescope" },
		{ "<leader>fw", ":Telescope grep_string<CR>", desc = "[F]ind current [W]ord" },
		{ "<leader>fd", ":Telescope diagnostics<CR>", desc = "[F]ind [D]iagnostics" },
		{ "<leader>fr", ":Telescope resume<CR>", desc = "[F]ind [R]esume" },
		{ "<leader>f.", ":Telescope oldfiles<CR>", desc = '[F]ind Recent Files ("." for repeat)' },
		{ "<leader>f ", ":Telescope buffers<CR>", desc = "[ ] Find existing buffers" },
		{
			"<leader>fm",
			function()
				local builtin = require("telescope.builtin")
				local themes = require("telescope.themes")
				builtin.man_pages(themes.get_ivy({
					initial_mode = "insert",
					sections = { "ALL" },
					winblend = 10,
					previewer = true,
					layout_config = { height = 25 },
				}))
			end,
			desc = "[F]ind [M]an pages",
		},
		{
			"<leader>/",
			function()
				local builtin = require("telescope.builtin")
				local themes = require("telescope.themes")
				builtin.current_buffer_fuzzy_find(themes.get_dropdown({
					winblend = 10,
					previewer = false,
					layout_config = { width = 170, height = 25 },
				}))
			end,
			desc = "[/] Find in current buffer",
		},
		{
			"<leader>fk",
			function()
				local builtin = require("telescope.builtin")
				local themes = require("telescope.themes")
				builtin.keymaps(themes.get_dropdown({
					winblend = 20,
					previewer = true,
					layout_config = { height = 30, width = 160 },
				}))
			end,
			desc = "[F]find [K]eymaps",
		},
		{
			"<leader>fn",
			function()
				local builtin = require("telescope.builtin")
				local themes = require("telescope.themes")
				builtin.find_files(themes.get_ivy({
					winblend = 20,
					prompt_title = "Neovim Config Files",
					cwd = vim.fn.stdpath("config"),
				}))
			end,
			desc = "[F]ind [N]vim Config",
		},
		{
			"<leader>f/",
			function()
				require("telescope.builtin").live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end,
			desc = "[F]ind [/] in Open Files",
		},
		{
			"<leader>fp",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
					prompt_title = "Search Packages",
				})
			end,
			desc = "[F]ind [P]ackages",
		},

		{ "<leader>g", group = "Gitsigns", icon = " "},
		{ "<leader>gb", ":Gitsigns blame_line<CR>", desc = "Git blame line" },
		{ "<leader>gp", ":Gitsigns preview_hunk<CR>", desc = "Preview git hunk" },
		{ "<leader>gr", ":Gitsigns reset_hunk<CR>", desc = "Reset git hunk" },


		{ "<leader>l", group = "Lsp", icon = "󰈮"},
		{ '<leader>la', function() vim.lsp.buf.code_action() end, desc = '[L]SP Code [A]ction' },
		{ '<leader>lr', function() vim.lsp.buf.rename() end, desc = '[R]ename' },
		{ '<leader>lD', function() vim.lsp.buf.declaration() end, desc = '[G]oto [D]eclaration' },
		{ '<leader>lr', function() require('telescope.builtin').lsp_references() end, desc = '[G]oto [R]eferences' },
		{ '<leader>li', function() require('telescope.builtin').lsp_implementations() end, desc = '[G]oto [I]mplementation' },
		{ '<leader>ld', function() require('telescope.builtin').lsp_definitions() end, desc = '[G]oto [D]efinition' },
		{ '<leader>lO', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'Open Document Symbols' },
		{ '<leader>lW', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, desc = 'Open Workspace Symbols' },
		{ '<leader>lt', function() require('telescope.builtin').lsp_type_definitions() end, desc = '[G]oto [T]ype Definition' },

	},
	{
		mode = "v",
		{ "<", "<gv", desc = "Indent left and reselect" },
		{ ">", ">gv", desc = "Indent right and reselect" },
		{ "p", '"_dP', desc = "Paste over selection without overwriting register" },
		{ "<leader>y", '"+y', desc = "Copy to system clipboard" },
		{ "<leader>p", '"+p', desc = "Past from system clipboard" },
		{ "<leader>d", '"_d', desc = "Delete without copying" },
	},
	{
		mode = "i",
		{ "jk", "<ESC>", desc = "Exit insert mode quickly" },

	},
	{
		mode = "x",
		{ "<Enter>", "an", desc = "Treesitter: Increment selection", remap = true },
		{ "<Backspace>", "in", desc = "Treesitter: Decriment selection", remap = true },
		{ 'gra', function() vim.lsp.buf.code_action() end, desc = '[G]oto Code [A]ction' },
	},
	{
		mode = "t",
		{'<Esc>', [[<C-\><C-n>]], desc = "Enter Normal mode on Terminal mode" },
	}

})

