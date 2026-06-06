export PAGER='less'
export LESS='-RFX'
export EDITOR='vim'
export VISUAL="$EDITOR"
export BROWSER='open'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)
