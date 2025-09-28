return {
  config = function()
    require("Comment").setup()
    local ft = require("Comment.ft")
    -- The default style is an HTML comment. This is a Django template comment.
    ft.set("htmldjango", "{# %s #}")
  end,
}
