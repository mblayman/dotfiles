return {
  config = function()
    require("which-key").setup({ preset = "modern" })

    -- Document existing key chains
    require("which-key").add({
      { "<leader>c", group = "[C]ode", hidden = true },
      { "<leader>r", group = "[R]ename", hidden = true },
      { "<leader>s", group = "[S]earch", hidden = true },
    })
  end,
}
