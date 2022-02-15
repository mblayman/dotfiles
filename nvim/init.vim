set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

luafile ~/.config/nvim/lua-language-server.lua
