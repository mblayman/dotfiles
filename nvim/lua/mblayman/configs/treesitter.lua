return {
  config = function()
    local languages = {
      "bash",
      "c",
      "go",
      "graphql",
      "lua",
      "markdown",
      "proto",
      "python",
      "rust",
      "templ",
      "toml",
      "vimdoc",
      "zig",
    }

    require("nvim-treesitter").setup()
    require("nvim-treesitter").install(languages)

    local group = vim.api.nvim_create_augroup("mblayman-treesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

  end,
}
