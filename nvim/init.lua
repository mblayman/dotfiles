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
