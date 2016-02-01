" enable plugin loading via pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" leave insert mode while keeping your hands on home row
inoremap jk <ESC>

" open NERDTree when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERTDTree with <C-n>
map <C-n> :NERDTreeToggle<CR>

" use solarized dark colorscheme
syntax enable
set background=dark
colorscheme solarized

set number
