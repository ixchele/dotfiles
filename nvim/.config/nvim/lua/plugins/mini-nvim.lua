return {
	{
		"echasnovski/mini.nvim",
		config = function()
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			--  etc...
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			-- etc...
			require("mini.surround").setup({
				custom_surroundings = {
					[")"] = { output = { left = "(", right = ")" } },
					["("] = { output = { left = "(", right = ")" } },
					["}"] = { output = { left = "{", right = "}" } },
					["{"] = { output = { left = "{", right = "}" } },
					["]"] = { output = { left = "[", right = "]" } },
					["["] = { output = { left = "[", right = "]" } },
					["<"] = { output = { left = "<", right = ">" } },
					[">"] = { output = { left = "<", right = ">" } },
				},
			})
			require("mini.pairs").setup({
				mappings = {
					['<'] = { action = 'open', pair = '<>', neigh_pattern = '^[^\\]' },
					['>'] = { action = 'close', pair = '<>', neigh_pattern = '^[^\\]' },
				}
			})
			require("mini.move").setup({
				mappings = {
 					right = "L",
 					up = "K",
 					left = "H",
 					down = "J",
				}
			})
		end,
	},
}
