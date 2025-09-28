return {
  config = function()
    require("telescope").setup({
      extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } },
    })

    -- Enable telescope extensions, if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.git_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
    vim.keymap.set(
      "n",
      "<leader>sa",
      builtin.find_files,
      { desc = "[S]earch [A]ll files" }
    )
    vim.keymap.set(
      "n",
      "<leader>ss",
      builtin.builtin,
      { desc = "[S]earch [S]elect Telescope" }
    )
    vim.keymap.set(
      "n",
      "<leader>sw",
      builtin.grep_string,
      { desc = "[S]earch current [W]ord" }
    )
    vim.keymap.set(
      "n",
      "<leader>sg",
      builtin.live_grep,
      { desc = "[S]earch by [G]rep" }
    )
    vim.keymap.set(
      "n",
      "<leader>sd",
      builtin.diagnostics,
      { desc = "[S]earch [D]iagnostics" }
    )
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set(
      "n",
      "<leader>s.",
      builtin.oldfiles,
      { desc = '[S]earch Recent Files ("." for repeat)' }
    )
    vim.keymap.set(
      "n",
      "<leader><leader>",
      builtin.git_files,
      { desc = "[ ] Search Files" }
    )

    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
