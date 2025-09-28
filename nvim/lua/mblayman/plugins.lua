return {
  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = require("mblayman.configs.which_key").config,
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
