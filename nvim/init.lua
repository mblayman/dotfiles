-- vim-plug is my Neovim package manager.
--
-- This plugin is fetched with my `boostrap.sh` script.
-- The plugin exists in the Neovim autoload directory
-- so that it is available as soon as this `init.lua` script is invoked
-- by Neovim.
local Plug = vim.fn['plug#']

-- All Neovim plugins are declared between `plug#begin` and `plug#end`.
--
-- vim-plug is only aware of a plugin if the `Plug` function is used
-- to declare it.
vim.call('plug#begin')

-- LSP progress UI
--
-- This plugin adds a bit of UI above the status line to show the progress
-- state of an LSP server if that state is available.
Plug 'j-hui/fidget.nvim'

-- The configuration plugin for Neovim LSP integration
--
-- This plugin provides configuration that integrates Neovim (an LSP client)
-- with one of the supported LSP servers listed with this plugin.
Plug 'neovim/nvim-lspconfig'

-- A dark theme
Plug 'tanvirtin/monokai.nvim'

-- Neovim LSP package manager
--
-- This plugin has the job of fetching LSP servers and clients
-- so that I don't have to. I get to specify something like "pyright"
-- and mason.nvim does the rest.
--
-- mason.nvim does *not* do any configuration of LSP clients and servers.
-- That configuration is delegating to other plugins.
Plug 'williamboman/mason.nvim'

-- Bridge between mason.nvim and lspconfig
--
-- This plugin is a compatibility layer that allows mason-installed LSP servers
-- to have easier configuration with the lspconfig plugin.
Plug 'williamboman/mason-lspconfig.nvim'

vim.call('plug#end')

-- Global configuration
--
-- Do this stuff before loading plugins so that plugins have a consistent behavior.

-- Set the leader key to spacebar.
--
-- This is, hands down, one of Vim's superpowers that is possible
-- because of modal editing.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Leader commands

-- Quick save
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')

-- Navigate up, down, left, and right between splits.
vim.keymap.set('n', '<leader>h', '<c-w>h')
vim.keymap.set('n', '<leader>j', '<c-w>j')
vim.keymap.set('n', '<leader>k', '<c-w>k')
vim.keymap.set('n', '<leader>l', '<c-w>l')

-- Plugin configuration
--
-- With the global config done, it's time to load all those cool plugins!

local servers = {'pyright'}

require('mason').setup()
require('mason-lspconfig').setup({
  -- Get the desired LSP servers automatically
  -- without needing a manual install action.
  ensure_installed = servers,
})

-- LSP server configuration
--
-- Most of these language configurations will only need to call `setup`,
-- but I'm not doing that in a loop because each could have a unique setup.
local lspconfig = require('lspconfig')

-- Python
lspconfig.pyright.setup({})

-- Enable LSP progress UI
require('fidget').setup({})

-- Theme
--
-- My theme selection has to work well f.lux. I mostly code at night
-- so my screen is often a deep amber color. I've found that I need high
-- contrast themes because the amber haze seems to reduce overall contrast.
vim.o.termguicolors = true
local monokai = require('monokai')
monokai.setup({})
