-- Global configuration
--
-- Do this stuff before loading plugins so that plugins have a consistent behavior.
-- Set the leader key to spacebar.
--
-- This is, hands down, one of Vim's superpowers that is possible
-- because of modal editing.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.rg_command = "rg --vimgrep -S"

require("mblayman/options")
require("mblayman/keymaps")
require("mblayman/lazy_bootstrap")
require("lazy").setup(require("mblayman/plugins"))

-- For some reason, Neovim is not recognizing the templ file extension.
-- There is probably a better way to do this, but this is fine for now.
vim.cmd([[autocmd BufNewFile,BufRead *.templ set ft=templ]])
