-- Search in Vim.
return {
  "jremmen/vim-ripgrep",
  config = function()
    -- Quick search
    vim.keymap.set("n", "<leader>a", ":Rg ")
  end,
}
