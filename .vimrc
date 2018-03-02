" enable plugin loading via pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

let mapleader=","

" edit vimrc in new split
nnoremap <leader>ev :vsplit $REPO_PATH/dotfiles/.vimrc<cr>

" leave insert mode while keeping your hands on home row
inoremap jk <ESC>

nnoremap H 0
nnoremap L $

" use solarized dark colorscheme
syntax enable
set background=dark

" show matching parentheses/brackets
set showmatch

" Minimum lines to keep above and below the cursor
set scrolloff=3

" Backspace and cursor keys wrap too
set whichwrap=b,s,h,l,<,>,[,]

" highlight search results
set hlsearch
" unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

" ignore case when searching if search string is all lowercase
:set ignorecase
:set smartcase

" force myself to not use ESC
inoremap <ESC> <NOP>

" show line numbers
set number

" highlight problematic white space
set list
" TODO:turn the tab off just for golang
set listchars=tab:\¦\ ,trail:•,extends:#,nbsp:.

" backspace
set backspace=indent,eol,start

" pastetoggle (sane indentation on pastes)
set pastetoggle=<F12>

" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow

" make sure airline-tmux extension is disabled to not overwrite tmux theme
let g:airline#extensions#tmuxline#enabled = 0

" source dotfiles/.vimrc
nnoremap <leader>so :!cp $REPO_PATH/dotfiles/.vimrc $MYVIMRC<CR>:so $MYVIMRC<CR>

" 'zoom' by breaking current window to new tab
nnoremap <leader>z :split<CR><C-w>T

" move a line down
nnoremap - ddp

" move a line up
nnoremap _ ddkP

" tab navigation
nnoremap <C-p> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>

" control-p
nnoremap <C-f> :CtrlP<CR>
" enable <C-p> to be used for something else
let g:ctrlp_map = '<Nop>'
" index hidden files in CtrlP
let g:ctrlp_show_hidden = 1

" NERDTree
nnoremap <C-a> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
