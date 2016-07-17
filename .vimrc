" enable plugin loading via pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

let mapleader=","

nnoremap <leader>ev :vsplit $REPO_DIR/dotfiles/.vimrc<cr>

" leave insert mode while keeping your hands on home row
inoremap jk <ESC>

nnoremap H 0
nnoremap L $

" Find git merge conflict markers
noremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

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

" ignore case when searching if search string is all lowercase
:set ignorecase
:set smartcase

" use ag for ack.vim searches if present
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" force myself to not use ESC
inoremap <ESC> <NOP>

" show line numbers
set number

" highlight problematic white space
set list
set listchars=tab:\¦\ ,trail:•,extends:#,nbsp:.

" backspace
set backspace=indent,eol,start

" pastetoggle (sane indentation on pastes)
set pastetoggle=<F12>

" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow

" vim-go mappings
au FileType go nnoremap <leader>Gd :GoDef<CR>

" fugitive mappings
" TODO: find a better way to clear shell history before running command
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <leader>gg :Git<space>

" make sure airline-tmux extension is disabled to not overwrite tmux theme
let g:airline#extensions#tmuxline#enabled = 0

" source dotfiles/.vimrc
nnoremap <leader>so :!cp $REPO_DIR/dotfiles/.vimrc $MYVIMRC<CR>:so $MYVIMRC<CR>

" 'zoom' by breaking current window to new tab
nnoremap <leader>z :split<CR><C-w>T

" close vim if NERDTree is only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" move a line down
nnoremap - ddp

" move a line up
nnoremap _ ddkP

" make word all caps
inoremap <c-u> <ESC>viwUea
nnoremap <leader>u viwUe

" tab navigation
nnoremap <C-p> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>

" control-p
nnoremap <C-f> :CtrlP<CR>
" enable <C-p> to be used for something else
let g:ctrlp_map = '<Nop>'
" index hidden files in CtrlP
let g:ctrlp_show_hidden = 1

" ack.vim
nnoremap <C-b> :Ack<space>

" NERDTree
nnoremap <C-a> :NERDTreeToggle<CR>

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
  silent !createTodoAndCleanPrevious
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

function! EditRepo(repoPath)
  execute "tab split " . a:repoPath
  execute "lcd " . a:repoPath
  tabm 0
endfunction
command! -nargs=1 -complete=file EditRepo :call EditRepo(<f-args>)
nnoremap <leader>er :EditRepo $REPO_DIR/
nnoremap <leader>eg :EditRepo $GOPATH/src/github.com/

function! EditScratch(scratchFile)
  silent !mkdir -p /tmp/scratch
  execute "tab split " . a:scratchFile
  lcd %:p:h
  tabm 0
endfunction
command! -nargs=1 -complete=file EditScratch :call EditScratch(<f-args>)
nnoremap <leader>es :EditScratch /tmp/scratch/

" open Notes and Todos when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | :call StartUpWithNoFilesSpecified() | endif
function! StartUpWithNoFilesSpecified()
  call EditNotes()
  call EditTodos()
  tabclose 1
endfunction

" prompt for command in vimux pane
map <leader>rp :VimuxPromptCommand<CR>
" run last command in vimux pane
map <Leader>rl :VimuxRunLastCommand<CR>
" close vimux pane
map <Leader>rq :VimuxCloseRunner<CR>
" zoom the tmux runner page
map <Leader>rz :VimuxZoomRunner<CR>
