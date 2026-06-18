return {
	"floating_docs",
	virtual = true,
	lazy = false,
	priority = 1000,
	config = function()
		local floating_docs_group = vim.api.nvim_create_augroup("FloatingDocs", { clear = true })

		vim.api.nvim_create_autocmd("VimEnter", {
			group = floating_docs_group,
			callback = function()
				local function open_man_in_floating_window(cmd_opts)
					local page = cmd_opts.args

					local width = math.min(79, math.floor(vim.o.columns))
					local height = math.floor(vim.o.lines * 0.8)
					local col = math.floor((vim.o.columns - width) / 2)
					local row = math.floor((vim.o.lines - height) / 2)

					local buf = vim.api.nvim_create_buf(false, true)

					local man_cmd = string.format("man %s | col -b", page)
					local lines = vim.fn.systemlist(man_cmd)

					if #lines == 0 or (lines[1] and lines[1]:match("No manual entry")) then
						vim.notify("No manual entry : " .. page, vim.log.levels.ERROR)
						return
					end

					vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

					vim.bo[buf].filetype = "man"
					vim.bo[buf].modifiable = false
					vim.bo[buf].readonly = true

					local win_config = {
						relative = "editor",
						width = width,
						height = height,
						col = col,
						row = row,
						style = "minimal",
						border = "rounded",
					}

					vim.api.nvim_open_win(buf, true, win_config)
				end

				vim.api.nvim_create_user_command("Man", open_man_in_floating_window, { force = true, nargs = "+" })
			end,
		})

		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = floating_docs_group,
			pattern = "*.txt",
			callback = function(args)
				if vim.bo[args.buf].filetype ~= "help" then return end

				local win_config = { relative = "" }
				pcall(function() win_config = vim.api.nvim_win_get_config(0) end)
				if win_config.relative ~= "" then return end

				local help_buf = args.buf
				vim.cmd("close")

				local width = math.min(78, math.floor(vim.o.columns))
				local height = math.floor(vim.o.lines * 0.8)
				local col = math.floor((vim.o.columns - width) / 2)
				local row = math.floor((vim.o.lines - height) / 2)

				local float_win_config = {
					relative = "editor",
					width = width,
					height = height,
					col = col,
					row = row,
					style = "minimal",
					border = "rounded",
				}
				vim.api.nvim_open_win(help_buf, true, float_win_config)
			end,
		})
	end
}
