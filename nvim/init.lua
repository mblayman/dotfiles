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

-- Neovim LSP completion source
--
-- This plugin provides more completion capabilities
-- that the Neovim client can expose to LSP servers.
-- The LSP server can then enrich what the completion engine can do.
Plug 'hrsh7th/cmp-nvim-lsp'

-- Neovim completion engine
--
-- This plugin is the core completion engine that can be fed completions
-- from sources like an LSP server or a snippet plugin.
Plug 'hrsh7th/nvim-cmp'

-- LSP progress UI
--
-- This plugin adds a bit of UI above the status line to show the progress
-- state of an LSP server if that state is available.
Plug 'j-hui/fidget.nvim'

-- Snippet engine
--
-- This is tool for doing fancy autocomplete of common activities
-- (e.g., making a function with a standard docstring)
--
-- TODO: learn more about this later. For now, nvim-cmp requires a snippet
-- engine for some reason and that's the only reason why I've included
-- this plugin.
Plug 'L3MON4D3/LuaSnip'

-- Guidelines UI for indentation
--
-- This plugin adds subtle guidelines at indentation stops
-- so that my eyes can follow the relevant scoping.
Plug 'lukas-reineke/indent-blankline.nvim'

-- The configuration plugin for Neovim LSP integration
--
-- This plugin provides configuration that integrates Neovim (an LSP client)
-- with one of the supported LSP servers listed with this plugin.
Plug 'neovim/nvim-lspconfig'

-- A programming language parser
--
-- Tree-sitter is a C library design to do parsing of programming languages.
-- It can do incremental parsing and builds a concrete syntax tree,
-- so it is well suited to be a parser for code in an editor like Neovim.
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- Syntax-aware text objects
--
-- Make Neovim's text objects (e.g., `ip` for "inner paragraph") smarter
-- and aware of the language syntax that is selected.
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

-- LuaSnip completion source connector
--
-- This plugin bridges the LuaSnip snippet engine
-- as a source for the Neovim completion engine.
Plug 'saadparwaiz1/cmp_luasnip'

-- A dark theme
Plug 'tanvirtin/monokai.nvim'

-- Git in Vim
Plug 'tpope/vim-fugitive'

-- Fugitive extensions (for Gbrowse GitHub links)
Plug 'tpope/vim-rhubarb'

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

-- Set the title of the tab to the filename.
vim.o.title = true

-- Enable line numbers.
vim.wo.number = true

-- Show relative numbers above and below the current number.
--
-- This is useful for now the jump distantce when calculating larger motions.
vim.wo.relativenumber = true

-- Set the number of reserved lines at the top and bottom before scrolling starts.
--
-- This lets me see some context above or below wherever I am so I'm not missing
-- related information to the line that I'm reading.
vim.wo.scrolloff = 10

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

local servers = {'pyright', 'sumneko_lua'}

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

-- Create the expanded capabilities set so that the LSP servers will know
-- that the Neovim client can do more.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- Enable LSP progress UI
require('fidget').setup({})

-- Completion engine (nvim-cmp)
--
-- To make use of all the cool LSP server stuff,
-- nvim-cmp needs to be configured to use the LSP as a source.
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  -- Tell nvim-cmp how to expand snippets.
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Set the key mappings for the completion engine to track.
  mapping = cmp.mapping.preset.insert({
    -- TODO: These mappings with Ctrl do not seem to be working.
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  -- Specify the completion sources.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- Theme
--
-- My theme selection has to work well f.lux. I mostly code at night
-- so my screen is often a deep amber color. I've found that I need high
-- contrast themes because the amber haze seems to reduce overall contrast.
vim.o.termguicolors = true
local monokai = require('monokai')
monokai.setup({})

-- Indentation guideline UI
require('indent_blankline').setup({
  char = '┊',
  show_trailing_blankline_indent = false,
})

-- Syntax highlighting and other language specific stuff.
--
-- nvim-treesitter supercharges syntax highlighting with better language support.
-- nvim-treesitter also improves the ability to navigate through code quickly.
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'go', 'lua', 'python', 'rust', 'help' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },

  -- Configuration for the nvim-treesitter-textobjects plugin
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>s'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>S'] = '@parameter.inner',
      },
    },
  },
})
