set nocompatible
filetype off

set undodir^=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

" Utility
Plug 'junegunn/vim-easy-align'
Plug 'dockyard/vim-easydir'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'justincampbell/vim-eighties'
Plug 'airblade/vim-gitgutter'

" Languages
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'fatih/vim-go'
Plug 'markcornick/vim-bats'
Plug 'rosstimson/bats.vim'
Plug 'tpope/vim-rails'

" color scheme
Plug 'Numkil/vim-distinguished'

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

let g:rspec_command = "!bundle exec rspec {spec}"
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

autocmd BufNewFile,BufRead *.bowerrc setf javascript
autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
autocmd FileType markdown set wrap

" NERDCommenter settings
let NERDRemoveExtraSpaces=1
let NERDSpaceDelims=1

map <leader># <plug>NERDCommenterToggle<CR>
