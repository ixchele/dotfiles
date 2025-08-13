-- Function to create the folder picker
local function create_folder_picker()
	-- Get all directories (excluding hidden ones)
	local dirs = vim.fn.systemlist('find . -type d -not -path "*/.*" | grep -v "^\\.$" | sort')
	local selected = {}
	local collapsed = {} -- Track collapsed root folders
	local current_line = 1
	local scroll_offset = 0

	-- Clean directory names (remove leading ./)
	for i, dir in ipairs(dirs) do
		dirs[i] = string.gsub(dir, "^%./", "")
	end

	-- Add "Load All" option at the top
	table.insert(dirs, 1, "** LOAD ALL **")

	-- Create floating window (bigger size)
	local buf = vim.api.nvim_create_buf(false, true)
	local width = 80
	local max_display_items = 25
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = max_display_items + 3,
		col = (vim.o.columns - width) / 2,
		row = (vim.o.lines - (max_display_items + 3)) / 2,
		style = "minimal",
		border = "rounded",
		title = " Select Folders to Load ",
		title_pos = "center",
	})

	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, "modifiable", true)
	vim.api.nvim_buf_set_option(buf, "readonly", false)

	-- Function to check if a folder is a root folder (no subfolders in the path)
	local function is_root_folder(folder_path)
		return not string.find(folder_path, "/")
	end

	-- Function to check if a subfolder belongs to a root folder
	local function is_subfolder_of(subfolder, root_folder)
		return string.find(subfolder, "^" .. root_folder .. "/")
	end

	-- Function to get visible directories (excluding collapsed subfolders)
	local function get_visible_dirs()
		local visible = {}
		for _, dir in ipairs(dirs) do
			local should_show = true

			-- If "Load All" is selected, collapse all root folders
			if selected["** LOAD ALL **"] then
				if not is_root_folder(dir) and dir ~= "** LOAD ALL **" then
					should_show = false
				end
			else
				-- Check if this directory is hidden by a collapsed parent
				if dir ~= "** LOAD ALL **" and not is_root_folder(dir) then
					for root_dir, _ in pairs(collapsed) do
						if is_subfolder_of(dir, root_dir) then
							should_show = false
							break
						end
					end
				end
			end

			if should_show then
				table.insert(visible, dir)
			end
		end
		return visible
	end

	-- Function to check if any folders are selected
	local function has_selections()
		for _, _ in pairs(selected) do
			return true
		end
		return false
	end

	-- Function to update display with proper scrolling
	local function update_display()
		local visible_dirs = get_visible_dirs()
		local display_height = math.min(#visible_dirs, max_display_items)

		-- Adjust current line if it's beyond visible directories
		if current_line > #visible_dirs then
			current_line = #visible_dirs
		end
		if current_line < 1 then
			current_line = 1
		end

		-- Adjust scroll offset to keep current line visible
		if current_line <= scroll_offset then
			scroll_offset = math.max(0, current_line - 1)
		elseif current_line > scroll_offset + display_height then
			scroll_offset = current_line - display_height
		end

		local lines = { "Press SPACE to select/deselect, ENTER to confirm, q to cancel", "" }

		-- Calculate visible range
		local visible_start = scroll_offset + 1
		local visible_end = math.min(scroll_offset + display_height, #visible_dirs)

		-- Add visible items
		for i = visible_start, visible_end do
			local dir = visible_dirs[i]
			local prefix = selected[dir] and "[x] " or "[ ] "

			-- Add collapse indicator for root folders (except Load All)
			if is_root_folder(dir) and dir ~= "** LOAD ALL **" then
				if collapsed[dir] or selected["** LOAD ALL **"] then
					prefix = prefix .. "▼ " -- Collapsed indicator
				else
					prefix = prefix .. "▶ " -- Expandable indicator
				end
			end

			local line = prefix .. dir

			if i == current_line then
				line = "> " .. line
			else
				line = "  " .. line
			end
			table.insert(lines, line)
		end

		-- Add scroll indicators if needed
		if scroll_offset > 0 then
			lines[2] = "↑ More items above ↑"
		end
		if visible_end < #visible_dirs then
			table.insert(lines, "↓ More items below ↓")
		end

		-- Set lines and apply highlighting
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

		-- Clear existing highlights
		vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)

		-- Apply syntax highlighting
		local line_offset = 2 -- Skip header lines
		for i = visible_start, visible_end do
			local line_num_in_display = (i - visible_start) + line_offset + 1
			local line_text = lines[line_num_in_display]
			local actual_line = line_num_in_display - 1 -- 0-indexed for nvim_buf_add_highlight
			local dir_name = visible_dirs[i]

			if line_text then
				-- Highlight folder paths
				local folder_start = string.find(line_text, "] ")
				if folder_start then
					-- Adjust for collapse indicators
					if is_root_folder(dir_name) and dir_name ~= "** LOAD ALL **" then
						folder_start = folder_start + 3 -- Account for "▼ " or "▶ "
					else
						folder_start = folder_start + 1
					end

					-- Color based on folder type
					if dir_name == "** LOAD ALL **" then
						vim.api.nvim_buf_add_highlight(buf, -1, "LoadAllText", actual_line, folder_start, -1)
					elseif is_root_folder(dir_name) then
						vim.api.nvim_buf_add_highlight(buf, -1, "RootFolder", actual_line, folder_start, -1)
					else
						vim.api.nvim_buf_add_highlight(buf, -1, "SubFolder", actual_line, folder_start, -1)
					end
				end

				-- Highlight collapse indicators
				if is_root_folder(dir_name) and dir_name ~= "** LOAD ALL **" then
					local indicator_start = string.find(line_text, "[▼▶]")
					if indicator_start then
						vim.api.nvim_buf_add_highlight(
							buf,
							-1,
							"CollapseIndicator",
							actual_line,
							indicator_start - 1,
							indicator_start
						)
					end
				end

				-- Highlight checkbox marks and cursor
				if string.find(line_text, "^> %[x%]") then
					-- Current line with selection
					vim.api.nvim_buf_add_highlight(buf, -1, "CursorMark", actual_line, 0, 1) -- >
					vim.api.nvim_buf_add_highlight(buf, -1, "CheckMark", actual_line, 3, 4) -- x only
				elseif string.find(line_text, "^> %[ %]") then
					-- Current line without selection
					vim.api.nvim_buf_add_highlight(buf, -1, "CursorMark", actual_line, 0, 1) -- >
				elseif string.find(line_text, "%[x%]") then
					-- Selected but not current
					vim.api.nvim_buf_add_highlight(buf, -1, "CheckMark", actual_line, 3, 4) -- x only
				end
			end
		end
	end

	-- Function to load files from selected directories
	local function load_selected_dirs()
		-- Check if any folders are selected
		if not has_selections() then
			vim.api.nvim_echo({ {
				"No directories selected!",
				"WarningMsg",
			} }, false, {})
			return
		end

		local count = 0

		-- Store information about current state
		local current_buf_before = vim.api.nvim_get_current_buf()
		local buf_name = vim.api.nvim_buf_get_name(current_buf_before)
		local buf_filetype = vim.api.nvim_buf_get_option(current_buf_before, "filetype")

		-- Check if we're in nvim-tree or netrw or other file explorer
		local is_tree_buffer = buf_filetype == "NvimTree" or buf_filetype == "netrw" or buf_name == ""

		-- Check if "Load All" is selected
		if selected["** LOAD ALL **"] then
			-- Load all files from workspace
			local files = vim.fn.systemlist('find . -type f -not -path "*/\\.*"')
			for _, file in ipairs(files) do
				local clean_file = string.gsub(file, "^%./", "")
				-- Skip certain directories and file types
				if
					not string.match(clean_file, "^%.git/")
					and not string.match(clean_file, "^node_modules/")
					and not string.match(clean_file, "%.png$")
					and not string.match(clean_file, "%.jpg$")
					and not string.match(clean_file, "%.gif$")
					and not string.match(clean_file, "%.o$")
				then
					vim.cmd("silent! badd " .. vim.fn.fnameescape(clean_file))
					count = count + 1
				end
			end
		else
			-- Load from selected directories only
			local dirs_to_load = {}
			for dir, _ in pairs(selected) do
				if dir ~= "** LOAD ALL **" then
					table.insert(dirs_to_load, dir)
				end
			end

			-- Load files from selected directories
			for _, dir in ipairs(dirs_to_load) do
				local files = vim.fn.systemlist("find ./" .. dir .. ' -type f -not -path "*/\\.*" 2>/dev/null')
				for _, file in ipairs(files) do
					local clean_file = string.gsub(file, "^%./", "")
					if
						not string.match(clean_file, "%.png$")
						and not string.match(clean_file, "%.jpg$")
						and not string.match(clean_file, "%.gif$")
						and not string.match(clean_file, "%.o$")
					then
						vim.cmd("silent! badd " .. vim.fn.fnameescape(clean_file))
						count = count + 1
					end
				end
			end
		end

		-- Handle buffer state after loading
		if is_tree_buffer then
			if vim.api.nvim_buf_is_valid(current_buf_before) then
				vim.api.nvim_set_current_buf(current_buf_before)
			end
		else
			if vim.api.nvim_buf_is_valid(current_buf_before) then
				vim.api.nvim_set_current_buf(current_buf_before)
			end
		end

		-- Force LSP to attach to all buffers silently
		vim.schedule(function()
			local current_buf = vim.api.nvim_get_current_buf()
			vim.cmd("silent! bufdo silent! LspStart")
			if vim.api.nvim_buf_is_valid(current_buf) then
				vim.api.nvim_set_current_buf(current_buf)
			end
		end)

		-- Colored success message
		vim.defer_fn(function()
			vim.api.nvim_echo({ {
				"✓ Loaded " .. count .. " files",
				"SuccessMsg",
			} }, false, {})
		end, 100)
	end

	-- Key mappings
	local function setup_keys()
		-- Space to select/deselect
		vim.keymap.set("n", "<Space>", function()
			local visible_dirs = get_visible_dirs()
			if current_line >= 1 and current_line <= #visible_dirs then
				local dir = visible_dirs[current_line]

				-- Handle "Load All" selection
				if dir == "** LOAD ALL **" then
					if selected[dir] then
						-- Unselect Load All and restore normal view
						selected[dir] = nil
						-- Unselect all folders
						for _, all_dir in ipairs(dirs) do
							selected[all_dir] = nil
							collapsed[all_dir] = nil
						end
					else
						-- Select Load All and collapse everything
						selected[dir] = true
						-- Select all root folders and collapse them
						for _, all_dir in ipairs(dirs) do
							if is_root_folder(all_dir) and all_dir ~= "** LOAD ALL **" then
								selected[all_dir] = true
								collapsed[all_dir] = true
							elseif not is_root_folder(all_dir) then
								selected[all_dir] = true
							end
						end
					end
				-- Handle root folder selection/deselection
				elseif is_root_folder(dir) then
					if selected[dir] then
						-- Unselect root folder and show its subfolders
						selected[dir] = nil
						collapsed[dir] = nil
						-- Also unselect any subfolders that were auto-selected
						for _, all_dir in ipairs(dirs) do
							if is_subfolder_of(all_dir, dir) then
								selected[all_dir] = nil
							end
						end
					else
						-- Select root folder and collapse its subfolders
						selected[dir] = true
						collapsed[dir] = true
						-- Auto-select all subfolders
						for _, all_dir in ipairs(dirs) do
							if is_subfolder_of(all_dir, dir) then
								selected[all_dir] = true
							end
						end
					end
				else
					-- Regular selection for non-root folders
					if selected[dir] then
						selected[dir] = nil
					else
						selected[dir] = true
					end
				end

				update_display()
			end
		end, { buffer = buf, nowait = true })

		-- Movement with proper scrolling
		vim.keymap.set("n", "j", function()
			local visible_dirs = get_visible_dirs()
			if current_line < #visible_dirs then
				current_line = current_line + 1
				update_display()
			end
		end, { buffer = buf, nowait = true })

		vim.keymap.set("n", "k", function()
			if current_line > 1 then
				current_line = current_line - 1
				update_display()
			end
		end, { buffer = buf, nowait = true })

		vim.keymap.set("n", "<Down>", function()
			local visible_dirs = get_visible_dirs()
			if current_line < #visible_dirs then
				current_line = current_line + 1
				update_display()
			end
		end, { buffer = buf, nowait = true })

		vim.keymap.set("n", "<Up>", function()
			if current_line > 1 then
				current_line = current_line - 1
				update_display()
			end
		end, { buffer = buf, nowait = true })

		-- Confirm (only works if folders are selected)
		vim.keymap.set("n", "<CR>", function()
			if has_selections() then
				vim.api.nvim_win_close(win, true)
				load_selected_dirs()
			else
				vim.api.nvim_echo({ {
					"No directories selected!",
					"WarningMsg",
				} }, false, {})
			end
		end, { buffer = buf, nowait = true })

		-- Quit
		vim.keymap.set("n", "q", function()
			vim.api.nvim_win_close(win, true)
		end, { buffer = buf, nowait = true })

		-- Disable other keys
		local keys_to_disable = { "i", "a", "o", "O", "x", "d", "c", "v", "V", ":", "/", "?" }
		for _, key in ipairs(keys_to_disable) do
			vim.keymap.set("n", key, "<Nop>", { buffer = buf, nowait = true })
		end
	end

	-- Set up custom highlight groups
	vim.api.nvim_set_hl(0, "SubFolder", { fg = "#8ba4b0" }) -- Sub folder paths
	vim.api.nvim_set_hl(0, "RootFolder", { fg = "#814c48" }) -- Root folder paths - NEW COLOR
	vim.api.nvim_set_hl(0, "LoadAllText", { fg = "#814c48" }) -- "** LOAD ALL **" text - NEW COLOR
	vim.api.nvim_set_hl(0, "CheckMark", { fg = "#814c48" }) -- x mark only
	vim.api.nvim_set_hl(0, "CursorMark", { fg = "#c8c093" }) -- > cursor - NEW COLOR
	vim.api.nvim_set_hl(0, "CollapseIndicator", { fg = "#8ba4b0" }) -- ▼ ▶ indicators
	vim.api.nvim_set_hl(0, "SuccessMsg", { fg = "#8a9a7b" }) -- Success message

	-- Initialize
	update_display()
	setup_keys()
end

-- Create the commands
vim.api.nvim_create_user_command("Loadall", create_folder_picker, {
	desc = "Load files from selected directories with picker",
})

-- Leader + l mapping
vim.keymap.set("n", "<leader>l", create_folder_picker, { desc = "Load files from selected folders" })
