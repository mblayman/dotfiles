local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Neovim LSP package manager
Plug 'williamboman/mason.nvim'

vim.call('plug#end')

require("mason").setup()
