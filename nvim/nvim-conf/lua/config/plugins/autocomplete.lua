return {
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets' },
		version = '1.*',
		opts = {
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = 'default',
				['<M-j>'] = { 'select_next', 'fallback' },
				['<M-k>'] = { 'select_prev', 'fallback' },
				['<S-Tab>'] = { 'select_and_accept' },
				['<A-n>'] = { 'snippet_forward', 'fallback' },
				['<A-b>'] = { 'snippet_backward', 'fallback' },
				['<C-n>'] = {},
				['<C-p>'] = {},
				['<C-y>'] = {},
			},
			appearance = {
				nerd_font_variant = 'mono'
			},
			completion = { documentation = { auto_show = false } },

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true }
		},
	}
}
