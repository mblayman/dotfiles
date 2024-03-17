-- Theme
--
-- My theme selection has to work well with f.lux. I mostly code at night
-- so my screen is often a deep amber color. I've found that I need high
-- contrast themes because the amber haze seems to reduce overall contrast.
return {
  "tanvirtin/monokai.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  init = function()
    vim.cmd.colorscheme("monokai")
  end,
}
