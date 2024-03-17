-- Keymaps
--
-- Make spacebar a noop when not followed by anything else.
--
-- Since spacebar is the leader key, don't do anything when the spacebar is hit
-- by itself.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
--
-- By default, Vim wants to treat a wrapping line as a single line.
-- Detect if there is line wrap, then go to the wrapped portion if there is.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Leader commands

-- Quick save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")

-- Insert pdb.
vim.keymap.set("n", "<leader>d", "obreakpoint()<esc>")

-- Navigate up, down, left, and right between splits.
vim.keymap.set("n", "<leader>h", "<c-w>h")
vim.keymap.set("n", "<leader>j", "<c-w>j")
vim.keymap.set("n", "<leader>k", "<c-w>k")
vim.keymap.set("n", "<leader>l", "<c-w>l")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
