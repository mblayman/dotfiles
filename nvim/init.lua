-- -- Neovim LSP completion source
-- --
-- -- This plugin provides more completion capabilities
-- -- that the Neovim client can expose to LSP servers.
-- -- The LSP server can then enrich what the completion engine can do.
-- Plug "hrsh7th/cmp-nvim-lsp"
--
-- -- Neovim completion engine
-- --
-- -- This plugin is the core completion engine that can be fed completions
-- -- from sources like an LSP server or a snippet plugin.
-- Plug "hrsh7th/nvim-cmp"
--
-- -- Snippet engine
-- --
-- -- This is tool for doing fancy autocomplete of common activities
-- -- (e.g., making a function with a standard docstring)
-- --
-- -- TODO: learn more about this later. For now, nvim-cmp requires a snippet
-- -- engine for some reason and that's the only reason why I've included
-- -- this plugin.
-- Plug "L3MON4D3/LuaSnip"
--
-- -- LuaSnip completion source connector
-- --
-- -- This plugin bridges the LuaSnip snippet engine
-- -- as a source for the Neovim completion engine.
-- Plug "saadparwaiz1/cmp_luasnip"
--
-- vim.call("plug#end")
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
require("mblayman/lazy_init")

-- -- Completion engine (nvim-cmp)
-- --
-- -- To make use of all the cool LSP server stuff,
-- -- nvim-cmp needs to be configured to use the LSP as a source.
-- local cmp = require "cmp"
-- local luasnip = require "luasnip"
--
-- cmp.setup({
--   -- Tell nvim-cmp how to expand snippets.
--   snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
--   -- Set the key mappings for the completion engine to track.
--   mapping = cmp.mapping.preset.insert({
--     -- TODO: These mappings with Ctrl do not seem to be working.
--     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping.complete(),
--     ["<CR>"] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = false,
--     }),
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, {"i", "s"}),
--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, {"i", "s"}),
--   }),
--   -- Specify the completion sources.
--   sources = {{name = "nvim_lsp"}, {name = "luasnip"}},
-- })

-- For some reason, Neovim is not recognizing the templ file extension.
-- There is probably a better way to do this, but this is fine for now.
vim.cmd [[autocmd BufNewFile,BufRead *.templ set ft=templ]]
