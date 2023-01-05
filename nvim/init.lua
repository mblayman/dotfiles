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

-- Include other LSP sources
--
-- This plugin makes it possible to use external tools and treat them
-- as sources that will be plugged into the LSP ecosystem.
-- By using this in combination with Mason, I can add tools like Black
-- without installing a dedicated Black plugin.
Plug 'jose-elias-alvarez/null-ls.nvim'

-- Search in Vim.
Plug 'jremmen/vim-ripgrep'

-- Allow local config files
--
-- This feature puts a guard on `exrc` so that Neovim is not unconditionally
-- sourcing random rc files.
Plug 'klen/nvim-config-local'

-- Snippet engine
--
-- This is tool for doing fancy autocomplete of common activities
-- (e.g., making a function with a standard docstring)
--
-- TODO: learn more about this later. For now, nvim-cmp requires a snippet
-- engine for some reason and that's the only reason why I've included
-- this plugin.
Plug 'L3MON4D3/LuaSnip'

-- Git info the buffer (e.g., gutter info)
Plug 'lewis6991/gitsigns.nvim'

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

-- Catch common weasel words like 'easy' when writing prose in Markdown.
Plug 'nicholaides/words-to-avoid.vim'

-- This is a dependency for telescope.
Plug 'nvim-lua/plenary.nvim'

-- A comment plugin that works as `gc`.
Plug 'numToStr/Comment.nvim'

-- A fancy status line
Plug 'nvim-lualine/lualine.nvim'

-- Fuzzy finder
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.0'})
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'make'})

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

-- Make the quickfix window modifiable for large find and replace operations.
Plug 'stefandtw/quickfix-reflector.vim'

-- A dark theme
Plug 'tanvirtin/monokai.nvim'

-- Smart completion of do/end.
Plug 'tpope/vim-endwise'

-- Git in Vim
Plug 'tpope/vim-fugitive'

-- Fugitive extensions (for Gbrowse GitHub links)
Plug 'tpope/vim-rhubarb'

-- Detect tabstop and shiftwidth automatically
Plug 'tpope/vim-sleuth'

-- Convenience shortcuts for quickly navigating quicklists and such.
Plug 'tpope/vim-unimpaired'

-- Make netrw more awesome.
Plug 'tpope/vim-vinegar'

-- Integrate a test runner.
Plug 'vim-test/vim-test'

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

vim.g.rg_command = 'rg --vimgrep -S'

-- Enable break indent
--
-- When a line wraps, the wrapped part will indent to the same level as the current line.
vim.o.breakindent = true

-- Set a line at column 81 to give a frame of reference.
vim.wo.colorcolumn = '81'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Hide instead of close files when opening a new file while there are unsaved changes
vim.o.hidden = false

-- Set highlight on search
vim.o.hlsearch = false

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- OS X does some weird stuff to PATH on zsh that messes with venvs.
-- Using bash is a safe alternative and I don't really need the power
-- of zsh through Vim.
vim.o.shell = '/bin/bash'

-- Always show the gutter, even when there are no problems.
vim.wo.signcolumn = 'yes'

-- Set the title of the tab to the filename.
vim.o.title = true

-- Save undo history
vim.o.undofile = true

-- Decrease update time
--
-- The time (in milliseconds) before writing to the swap file.
-- I don't know if I actually benefit from this.
vim.o.updatetime = 250

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

-- Keymaps

-- Make spacebar a nop when not followed by anything else.
--
-- Since spacebar is the leader key, don't do anything when the spacebar is hit
-- by itself.
vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', {silent = true})

-- Remap for dealing with word wrap
--
-- By default, Vim wants to treat a wrapping line as a single line.
-- Detect if there is line wrap, then go to the wrapped portion if there is.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
               {expr = true, silent = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
               {expr = true, silent = true})

-- Leader commands

-- Run a test file.
vim.keymap.set('n', '<leader>f', ':TestFile<cr>', {silent = true})

-- Run a test.
vim.keymap.set('n', '<leader>t', ':TestNearest<cr>', {silent = true})

-- Quick search
vim.keymap.set('n', '<leader>a', ':Rg ')

-- Quick save
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')

-- Insert pdb.
vim.keymap.set('n', '<leader>d', 'obreakpoint()<esc>')

-- Navigate up, down, left, and right between splits.
vim.keymap.set('n', '<leader>h', '<c-w>h')
vim.keymap.set('n', '<leader>j', '<c-w>j')
vim.keymap.set('n', '<leader>k', '<c-w>k')
vim.keymap.set('n', '<leader>l', '<c-w>l')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- TODO: This doesn't seem to work. I should figure out why.
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
                                                    {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

-- Plugin configuration
--
-- With the global config done, it's time to load all those cool plugins!

-- telescope configuration
require('telescope').setup {
    defaults = {mappings = {i = {['<C-u>'] = false, ['<C-d>'] = false}}}
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
               {desc = '[?] Find recently opened files'})
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
               {desc = '[ ] Find existing buffers'})
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require(
                                                               'telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false
    })
end, {desc = '[/] Fuzzily search in current buffer]'})

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').git_files,
               {desc = '[S]earch [F]iles'})
vim.keymap.set('n', '<leader>sa', require('telescope.builtin').find_files,
               {desc = '[S]earch [A]ll files'})
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags,
               {desc = '[S]earch [H]elp'})
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
               {desc = '[S]earch current [W]ord'})
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep,
               {desc = '[S]earch by [G]rep'})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
               {desc = '[S]earch [D]iagnostics'})

-- LSP settings.

-- This autocommand group is for attaching a format on save option
-- to each buffer.
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then desc = 'LSP: ' .. desc end

        vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references,
         '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,
         '[D]ocument [S]ymbols')
    nmap('<leader>ws',
         require('telescope.builtin').lsp_dynamic_workspace_symbols,
         '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format',
                                         function(_) vim.lsp.buf.format() end, {
        desc = 'Format current buffer with LSP'
    })

    -- Enable format on write.
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({bufnr = bufnr}) end
        })
    end
end

local servers = {
    'clangd', -- C
    'gopls', -- Go
    'pyright', -- Python
    'sumneko_lua' -- Lua
    -- zls is not installing successfully (maybe it takes too long to compile)
    -- so I'm disabling it until the future where I actually use the language.
    -- 'zls', -- Zig
}

require('mason').setup()
require('mason-lspconfig').setup({
    -- Get the desired LSP servers automatically
    -- without needing a manual install action.
    ensure_installed = servers
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

-- Go
lspconfig.gopls.setup({capabilities = capabilities, on_attach = on_attach})

-- Lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {globals = {'vim'}},
            workspace = {
                -- Tell the language server to stop prompting me
                -- to configure my project as a LOVE project.
                checkThirdParty = false,

                library = vim.api.nvim_get_runtime_file('', true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
})

-- Python
lspconfig.pyright.setup({capabilities = capabilities, on_attach = on_attach})

-- Enable other tools that can be used by LSP

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.lua_format, -- Lua
        null_ls.builtins.formatting.black, null_ls.builtins.formatting.isort -- Python
    },
    on_attach = on_attach
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
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    -- Set the key mappings for the completion engine to track.
    mapping = cmp.mapping.preset.insert({
        -- TODO: These mappings with Ctrl do not seem to be working.
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    -- Specify the completion sources.
    sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}}
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
    show_trailing_blankline_indent = false
})

-- Gitsigns configuration
require('gitsigns').setup({
    signs = {
        add = {text = '+'},
        change = {text = '~'},
        delete = {text = '_'},
        topdelete = {text = '‾'},
        changedelete = {text = '~'}
    }
})

-- Set lualine as statusline
require('lualine').setup({
    options = {
        icons_enabled = false,
        -- This theme is close enough.
        theme = 'onedark',
        component_separators = '|',
        section_separators = ''
    }
})

-- Syntax highlighting and other language specific stuff.
--
-- nvim-treesitter supercharges syntax highlighting with better language support.
-- nvim-treesitter also improves the ability to navigate through code quickly.
require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'c', 'go', 'help', 'lua', 'markdown', 'python', 'rust', 'toml', 'zig'
    },

    highlight = {enable = true},
    indent = {enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>'
        }
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
                ['ic'] = '@class.inner'
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        },
        swap = {
            enable = true,
            swap_next = {['<leader>s'] = '@parameter.inner'},
            swap_previous = {['<leader>S'] = '@parameter.inner'}
        }
    }
})

-- Enable the quick comment plugin.
require('Comment').setup()
local ft = require('Comment.ft')
-- The default style is an HTML comment. This is a Django template comment.
ft.set('htmldjango', '{# %s #}')

require('config-local').setup({
    -- Support the local_vimrc plugin filename that I used to use.
    config_files = {'_vimrc_local.vim', '.vimrc', '.vimrc.lua'}
})
