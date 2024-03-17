-- Allow local config files
--
-- This feature puts a guard on `exrc` so that Neovim is not unconditionally
-- sourcing random rc files.
return {
  "klen/nvim-config-local",
  opts = {
    -- Support the local_vimrc plugin filename that I used to use.
    config_files = { "_vimrc_local.vim", ".vimrc", ".vimrc.lua" },
  },
}
