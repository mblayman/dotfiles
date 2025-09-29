return {
  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = require("mblayman.configs.which_key").config,
  },
  -- Neovim autocompletion engine
  --
  -- This plugin is the core completion engine that can be fed completions
  -- from sources like an LSP server or a snippet plugin.
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        -- Snippet engine
        --
        -- This is tool for doing fancy autocomplete of common activities
        -- (e.g., making a function with a standard docstring)
        --
        -- TODO: learn more about this later. For now, nvim-cmp requires a snippet
        -- engine for some reason and that's the only reason why I've included
        -- this plugin.
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      -- LuaSnip completion source connector
      --
      -- This plugin bridges the LuaSnip snippet engine
      -- as a source for the Neovim completion engine.
      "saadparwaiz1/cmp_luasnip", --
      -- Neovim LSP completion source
      --
      -- This plugin provides more completion capabilities
      -- that the Neovim client can expose to LSP servers.
      -- The LSP server can then enrich what the completion engine can do.
      "hrsh7th/cmp-nvim-lsp", --
      "hrsh7th/cmp-path",
    },
    config = require("mblayman.configs.nvim_cmp").config,
  },
  -- Search in Vim.
  {
    "jremmen/vim-ripgrep",
    config = require("mblayman.configs.ripgrep").config,
  },
  -- Allow local config files
  --
  -- This feature puts a guard on `exrc` so that Neovim is not unconditionally
  -- sourcing random rc files.
  {
    "klen/nvim-config-local",
    opts = require("mblayman.configs.config_local").opts,
  },
  -- Git info in the buffer (e.g., gutter info)
  {
    "lewis6991/gitsigns.nvim",
    opts = require("mblayman.configs.gitsigns").opts,
  },
  -- Guidelines UI for indentation
  --
  -- This plugin adds subtle guidelines at indentation stops
  -- so that my eyes can follow the relevant scoping.
  --
  -- If I ever need to include snacks some day, it has an indent option
  -- that could probably replace this plugin.
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  -- The configuration plugin for Neovim LSP integration
  --
  -- This plugin provides configuration that integrates Neovim (an LSP client)
  -- with one of the supported LSP servers listed with this plugin.
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Neovim LSP package manager
      --
      -- This plugin has the job of fetching LSP servers and clients
      -- so that I don't have to. I get to specify something like "pyright"
      -- and mason.nvim does the rest.
      --
      -- mason.nvim does *not* do any configuration of LSP clients and servers.
      -- That configuration is delegating to other plugins.
      "williamboman/mason.nvim", --
      -- Bridge between mason.nvim and lspconfig
      --
      -- This plugin is a compatibility layer that allows mason-installed LSP servers
      -- to have easier configuration with the lspconfig plugin.
      "williamboman/mason-lspconfig.nvim",
      -- Automatically install LSPs and related tools to stdpath for neovim
      "WhoIsSethDaniel/mason-tool-installer.nvim", --
      -- LSP progress UI
      --
      -- This plugin adds a bit of UI above the status line to show the progress
      -- state of an LSP server if that state is available.
      { "j-hui/fidget.nvim", opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { "folke/neodev.nvim", opts = {} },
    },
    config = require("mblayman.configs.nvim_lspconfig").config,
  },
  -- Catch common weasel words like 'easy' when writing prose in Markdown.
  {
    "nicholaides/words-to-avoid.vim",
  },
  -- A comment plugin that works as `gc`.
  {
    "numToStr/Comment.nvim",
    config = require("mblayman.configs.comment").config,
  },
  -- A fancy status line
  {
    "nvim-lualine/lualine.nvim",
    opts = require("mblayman.configs.lualine").opts,
  },
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim", -- dependency of telescope for utility functions
      "nvim-telescope/telescope-ui-select.nvim", -- Sets `vim.ui.select` to telescope.
      "nvim-tree/nvim-web-devicons", -- Adds icons like filetype icons.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = require("mblayman.configs.telescope").config,
  },
  -- A programming language parser
  --
  -- Tree-sitter is a C library design to do parsing of programming languages.
  -- It can do incremental parsing and builds a concrete syntax tree,
  -- so it is well suited to be a parser for code in an editor like Neovim.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      -- Syntax-aware text objects
      --
      -- Make Neovim's text objects (e.g., `ip` for "inner paragraph") smarter
      -- and aware of the language syntax that is selected.
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = require("mblayman.configs.treesitter").opts,
    config = require("mblayman.configs.treesitter").config,
  },
  -- Make the quickfix window modifiable for large find and replace operations.
  {
    "stefandtw/quickfix-reflector.vim",
  },
  -- Autoformat
  {
    "stevearc/conform.nvim",
    opts = require("mblayman.configs.conform").opts,
  },
  -- Theme
  --
  -- TODO: Do I still need this??? How can I do dynamic theme selection?
  --
  -- My theme selection has to work well with f.lux. I mostly code at night
  -- so my screen is often a deep amber color. I've found that I need high
  -- contrast themes because the amber haze seems to reduce overall contrast.
  {
    "tanvirtin/monokai.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.cmd.colorscheme("monokai")
    end,
  },
  "tpope/vim-endwise", -- Smart completion of do/end.
  "tpope/vim-fugitive", -- Git in Vim
  "tpope/vim-rhubarb", -- Fugitive extensions (for Gbrowse GitHub links)
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  "tpope/vim-unimpaired", -- Shortcuts for quickly navigating quicklists and such.
  "tpope/vim-vinegar", -- Make netrw more awesome. oil.nvim might be a good alternative.
  -- Integrate a test runner.
  {
    "vim-test/vim-test",
    config = require("mblayman.configs.vim_test").config,
  },
}
