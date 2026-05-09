return {
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")

    vim.keymap.set({ "x", "o" }, "aa", function()
      select.select_textobject("@parameter.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ia", function()
      select.select_textobject("@parameter.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      move.goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]]", function()
      move.goto_next_start("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      move.goto_next_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "][", function()
      move.goto_next_end("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      move.goto_previous_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[[", function()
      move.goto_previous_start("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      move.goto_previous_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[]", function()
      move.goto_previous_end("@class.outer", "textobjects")
    end)

    vim.keymap.set("n", "<leader>S", function()
      swap.swap_next("@parameter.inner")
    end)
  end,
}
