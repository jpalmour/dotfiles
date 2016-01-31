" enable plugin loading via pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" leave insert mode while keeping your hands on home row
inoremap jk <ESC>
