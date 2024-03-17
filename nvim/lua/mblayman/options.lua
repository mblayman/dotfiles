-- Enable break indent
--
-- When a line wraps, the wrapped part will indent to the same level as the current line.
vim.opt.breakindent = true

-- Set a line at column 81 to give a frame of reference.
vim.opt.colorcolumn = "81"

-- Hide instead of close files when opening a new file while there are unsaved changes
vim.opt.hidden = false

-- Set highlight on search
vim.opt.hlsearch = false

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Enable mouse mode
vim.opt.mouse = "a"

-- OS X does some weird stuff to PATH on zsh that messes with venvs.
-- Using bash is a safe alternative and I don't really need the power
-- of zsh through Vim.
vim.opt.shell = "/bin/bash"

-- Always show the gutter, even when there are no problems.
vim.opt.signcolumn = "yes"

-- Set the title of the tab to the filename.
vim.opt.title = true

-- Save undo history
vim.opt.undofile = true

-- Decrease update time
--
-- The time (in milliseconds) before writing to the swap file.
-- I don't know if I actually benefit from this.
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Enable line numbers.
vim.opt.number = true

-- Show relative numbers above and below the current number.
--
-- This is useful for now the jump distantce when calculating larger motions.
vim.opt.relativenumber = true

-- Set the number of reserved lines at the top and bottom before scrolling starts.
--
-- This lets me see some context above or below wherever I am so I'm not missing
-- related information to the line that I'm reading.
vim.opt.scrolloff = 10
