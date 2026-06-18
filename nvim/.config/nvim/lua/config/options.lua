-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

-- --- Globals ---
vim.g.have_nerd_font = true    -- Tell plugins that a Nerd Font is active
vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/snippets"

-- --- UI / Display ---
opt.number = true              -- Show line numbers
opt.relativenumber = true      -- Relative line numbers (essential for vertical jumps)
opt.signcolumn = "yes"         -- Always show the sign column to prevent UI jumps with LSP
opt.cursorline = true          -- Highlight the current line
opt.termguicolors = true       -- Enable 24-bit RGB colors for modern themes
opt.showmode = true           -- Hide mode messages (e.g., -- INSERT --) since statusline handles it
opt.scrolloff = 15             -- Minimum number of lines to keep above/below the cursor
opt.sidescrolloff = 8          -- Minimum number of columns to keep to the left/right of the cursor

-- --- Text & Indentation ---
opt.tabstop = 4                -- Number of spaces that a <Tab> counts for
opt.shiftwidth = 4             -- Size of an indent
opt.expandtab = false           -- Convert tabs to spaces
opt.smartindent = true         -- Insert indents automatically depending on language syntax
opt.wrap = false               -- Disable line wrapping
opt.breakindent = true         -- Wrap long lines with an indent (if wrap is enabled)

-- --- Search ---
opt.ignorecase = true          -- Ignore case in search patterns...
opt.smartcase = true           -- ...unless the search pattern contains upper case characters
opt.hlsearch = true           -- Clear highlights after search is done
opt.incsearch = true           -- Show search results incrementally while typing
opt.inccommand = "split"       -- Preview substitutions (`:%s`) in a split window
opt.showmatch = true           -- Briefly jump to matching brackets/parentheses

-- --- Editor Behavior ---
opt.mouse = "a"                -- Enable mouse support in all modes
-- opt.clipboard = "unnamedplus"   -- Sync with system clipboard (allows global copy/paste)
opt.splitright = true          -- Vertical splits open to the right
opt.splitbelow = true          -- Horizontal splits open below
opt.autowrite = true           -- Automatically save before commands like :next and :make
opt.updatetime = 250           -- Faster completion and diagnostic updates (ms)
opt.timeoutlen = 300           -- Time to wait for a mapped sequence to complete (ms)

-- --- Files & History ---
opt.swapfile = false           -- Disable swap files
opt.backup = false             -- Disable backup files
opt.undofile = true            -- Save undo history to a file (persists after closing Nvim)

-- --- Whitespace & Style ---
opt.list = true                -- Show hidden characters
opt.listchars = { tab = "> ", trail = "·", nbsp = " " }

-- Advanced cursor configuration (shape and blinking depending on the mode)
-- opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,i:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175"
