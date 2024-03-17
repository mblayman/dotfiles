-- Integrate a test runner.
return {
  "vim-test/vim-test",
  config = function()
    vim.g["test#custom_runners"] = { lua = { "luatest" } }

    -- Run a test file.
    vim.keymap.set("n", "<leader>f", ":TestFile<cr>", { silent = true })

    -- Run a test.
    vim.keymap.set("n", "<leader>t", ":TestNearest<cr>", { silent = true })
  end,
}
