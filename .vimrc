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

" open NERTDTree with <C-n>
map <C-n> :NERDTreeToggle<CR>

" use solarized dark colorscheme
syntax enable
set background=dark
colorscheme solarized

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

" vim-go mappings
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>es <Plug>(go-def-split)
au FileType go nmap <Leader>ev <Plug>(go-def-vertical)
au FileType go nmap <Leader>et <Plug>(go-def-tab)
au FileType go nmap <Leader>od <Plug>(go-doc)
au FileType go nmap <Leader>ov <Plug>(go-doc-vertical)
au FileType go nmap <Leader>ob <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)

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

" vim markdown preview mappings
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'

" display all buffers when only one tab is open
let g:airline#extensions#tabline#enabled = 1

" make sure airline-tmux extension is disbaled to not overwrite tmux theme
let g:airline#extensions#tmuxline#enabled = 0

" change local current dir to that of file in current window
autocmd BufEnter * silent! lcd %:p:h
