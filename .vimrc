set nocompatible
filetype off

set undodir^=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'

Plug 'dockyard/vim-easydir'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/nerdcommenter'

Plug 'Lokaltog/vim-distinguished'

call plug#end()

" Sign and number columns
highlight SignColumn ctermbg=0
highlight NonText ctermbg=0 ctermfg=0
highlight Vertsplit ctermbg=233 ctermfg=233

" Tabs
highlight! link TabLineFill CursorColumn
highlight TabLine ctermfg=7 ctermbg=234 cterm=none
highlight TabLineSel ctermfg=166 ctermbg=234

" Fancy Characters
set listchars=tab:-\ ,
set list

set linebreak
set number
set scrolloff=5

set t_Co=256
set background=dark
colorscheme distinguished

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4

set nosmartindent

map <up> gk
imap <up> <C-o>gk
map <down> gj
imap <down> <C-o>gj
map <home> g<home>
imap <home> <C-o>g<home>
map <end> g<end>
imap <end> <C-o>g<end>

set hlsearch

set ignorecase
set smartcase
set incsearch

let mapleader=","

set shell=/bin/sh

autocmd BufNewFile,BufReadPost * let b:clean_on_open = search('\s\+$', 'nw') == 0
autocmd BufWritePre * if get(b:, 'clean_on_open', 0) | %s/\s\+$//e | endif

autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
autocmd FileType markdown set wrap

" NERDCommenter settings
let NERDRemoveExtraSpaces=1
let NERDSpaceDelims=1

map <leader># <plug>NERDCommenterToggle<CR>
