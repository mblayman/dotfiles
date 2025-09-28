return {
  -- Search in Vim.
  {
    "jremmen/vim-ripgrep",
    config = require("mblayman.configs.ripgrep").config,
  },
  "nicholaides/words-to-avoid.vim", -- Catch common weasel words like 'easy' when writing prose in Markdown.
  "stefandtw/quickfix-reflector.vim", -- Make the quickfix window modifiable for large find and replace operations.
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
}
