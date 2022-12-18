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

-- Neovim LSP package manager
--
-- This plugin has the job of fetching LSP servers and clients
-- so that I don't have to. I get to specify something like "pyright"
-- and mason.nvim does the rest.
--
-- mason.nvim does *not* do any configuration of LSP clients and servers.
-- That configuration is delegating to other plugins.
Plug 'williamboman/mason.nvim'

vim.call('plug#end')

require("mason").setup()
