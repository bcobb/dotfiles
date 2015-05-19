set nocompatible
filetype off

set undodir^=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

" Templates
Plug 'mustache/vim-mode'
Plug 'nono/vim-handlebars'
Plug 'mxw/vim-jsx'

" Utility
Plug 'junegunn/vim-easy-align'
Plug 'dockyard/vim-easydir'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kien/rainbow_parentheses.vim'
Plug 'justincampbell/vim-eighties'
Plug 'airblade/vim-gitgutter'
Plug 'rking/ag.vim'

" Languages
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'pangloss/vim-javascript'
Plug 'wlangstroth/vim-haskell'
Plug 'kchmck/vim-coffee-script'
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'wting/rust.vim'
Plug 'fatih/vim-go'
Plug 'markcornick/vim-bats'
Plug 'rosstimson/bats.vim'
Plug 'tpope/vim-rails'

" color scheme
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

let g:rspec_command = "!bundle exec rspec {spec}"
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f -and -not -path \"tmp/**/*\"", "", ":e")<cr>
nnoremap <leader>g :call SelectaCommand("find * -type f -and -not -path \"tmp/**/*\"", "", ":tabe")<cr>
nnoremap <leader>u :call SelectaCommand("ag -l " . expand("<cword>"), "", ":tabe")<cr>

autocmd BufNewFile,BufRead *.bowerrc setf javascript
autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
autocmd FileType markdown set wrap

" NERDCommenter settings
let NERDRemoveExtraSpaces=1
let NERDSpaceDelims=1

map <leader># <plug>NERDCommenterToggle<CR>

" rainbow_parentheses.vim
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]
let g:rbpt_max = len(g:rbpt_colorpairs)
