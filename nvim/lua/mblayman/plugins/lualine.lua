-- A fancy status line
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = false,
      -- This theme is close enough.
      theme = "onedark",
      component_separators = "|",
      section_separators = "",
    },
  },
}
