set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

set undodir^=~/.vim/undo

Bundle 'gmarik/vundle'

Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-sensible'
Bundle 'pangloss/vim-javascript'
Bundle 'wlangstroth/vim-haskell'
Bundle 'nono/vim-handlebars'
Bundle 'kchmck/vim-coffee-script'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-fireplace'
Bundle 't9md/vim-ruby-xmpfilter'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'jnwhiteh/vim-golang'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'mustache/vim-mode'

set linebreak
set number
set scrolloff=5

set t_Co=256
set background=dark
colorscheme distinguished

set ts=2
set shiftwidth=2
set expandtab
set shiftround

set nosmartindent

map <up> gk
imap <up> <C-o>gk
map <down> gj
imap <down> <C-o>gj
map <home> g<home>
imap <home> <C-o>g<home>
map <end> g<end>
imap <end> <C-o>g<end>

map <F4> <Plug>(xmpfilter-mark)
map <F5> <Plug>(xmpfilter-run)

set hlsearch

set ignorecase
set smartcase
set incsearch

let mapleader=","

set shell=/bin/sh

" Test runners inspired by @garybernhardt
function! RunTests(filename)
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!cucumber " . a:filename
    else
        if filereadable("script/test")
            exec ":!RAILS_ENV=test script/test " . a:filename
        elseif filereadable("spec/spec.opts") " legacy cruft
            exec ":!RAILS_ENV=test spec " . a:filename
        elseif filereadable("Gemfile")
            exec ":!RAILS_ENV=test bundle exec rspec " . a:filename
        else
            exec ":!RAILS_ENV=test rspec " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

map <leader>d :!bundle exec rspec --debugger %<cr>
map <leader>r :!bundle exec rspec --debugger -t focus %<cr>
map <leader>f :!bundle exec rspec -t focus %<cr>
map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>
map <leader>w :w\|:!cucumber --profile wip<cr>

map <leader>ls :call RunLegacySpecs()<cr>

let g:ftplugin_sql_omni_key       = '<M-0>'
let g:ftplugin_sql_omni_key_right = '<Right>'
let g:ftplugin_sql_omni_key_left  = '<Left>'

au BufNewFile,BufRead *.bowerrc setf javascript
