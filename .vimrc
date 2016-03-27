" enable plugin loading via pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

let mapleader=","

" leave insert mode while keeping your hands on home row
inoremap jk <ESC>

" open NERDTree when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Find git merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" use solarized dark colorscheme
syntax enable
set background=dark
colorscheme solarized

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

" force myself to not use ESC
inoremap <ESC> <NOP>

" show line numbers
set number

" highlight problematic white space
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" backspace
set backspace=indent,eol,start

" pastetoggle (sane indentation on pastes)
set pastetoggle=<F12>

" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow

" vim-go mappings
au FileType go nmap <leader>Gr <Plug>(go-run)
au FileType go nmap <leader>Gb <Plug>(go-build)
au FileType go nmap <leader>Gt <Plug>(go-test)
au FileType go nmap <leader>Gc <Plug>(go-coverage)
au FileType go nmap <Leader>Ges <Plug>(go-def-split)
au FileType go nmap <Leader>Gev <Plug>(go-def-vertical)
au FileType go nmap <Leader>Get <Plug>(go-def-tab)
au FileType go nmap <Leader>Gos <Plug>(go-doc)
au FileType go nmap <Leader>Gov <Plug>(go-doc-vertical)
au FileType go nmap <Leader>Gob <Plug>(go-doc-browser)
au FileType go nmap <Leader>Gs <Plug>(go-implements)

" fugitive mappings
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gi :Git add -p %<CR>
nnoremap <silent> <leader>gg :SignifyToggle<CR>

" make sure airline-tmux extension is disbaled to not overwrite tmux theme
let g:airline#extensions#tmuxline#enabled = 0

" vim-indent-guides settings
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
if 'dark' == &background
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
else
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
endif

" source dotfiles/.vimrc
nnoremap <leader>so :!source $REPO_DIR/dotfiles/bootstrap.sh<CR>:so $MYVIMRC<CR>

" 'zoom' by breaking current window to new tab
nnoremap <leader>z :split<CR><C-w>T

" close vim if NERDTree is only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" move a line down
map - ddp

" move a line up
map _ ddkP

" tab navigation
nnoremap <C-p> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>

" control-p
map <C-f> :CtrlP<CR>

" NERDTree
map <C-a> :NERDTreeToggle<CR>

function! EditTodos()
  tablast
  let lastTabCWD=getcwd()
  if lastTabCWD == $TODO_DIR
    return
  endif
  if lastTabCWD == $NOTES_DIR
    tabprevious
    let secondToLastTabCWD=getcwd()
    if secondToLastTabCWD == $TODO_DIR
      return
    endif
  endif
  silent !createTodo
  let todoFilePath=$TODO_DIR . '/' . system('todoFileName')
  execute "tab split " . todoFilePath
  lcd $TODO_DIR
endfunction
nnoremap <leader>et :call EditTodos()<CR>

function! EditNotes()
tablast
  let lastTabCWD=getcwd()
  if lastTabCWD == $NOTES_DIR
    return
  endif
  execute "tab split " . $NOTES_DIR
  lcd $NOTES_DIR
endfunction
nnoremap <leader>en :call EditNotes()<CR>

command! -nargs=1 -complete=file EditRepo :call EditRepo(<f-args>)
function! EditRepo(repoPath)
  execute "tab split " . a:repoPath
  execute "lcd " . a:repoPath
  tabm 0
endfunction
nnoremap <leader>er :EditRepo $REPO_DIR/
