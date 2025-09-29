return {
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "go",
      "graphql",
      "lua",
      "markdown",
      "python",
      "rust",
      "templ",
      "toml",
      "vimdoc",
      "zig",
    },
    auto_install = true,
    ignore_install = {},
    sync_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    },
    -- Configuration for the nvim-treesitter-textobjects plugin
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
      },
      swap = {
        enable = true,
        swap_next = { ["<leader>S"] = "@parameter.inner" },
        -- swap_previous = { ["<leader>S"] = "@parameter.inner" },
      },
    },
  },
  -- A config function is needed because treesitter wants to call `setup`
  -- on `nvim-treesitter.configs` and not just `nvim-treesitter`.
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
