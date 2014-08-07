ZSH=$HOME/lib/oh-my-zsh

ZSH_THEME="gentoo"

plugins=(git)

source $ZSH/oh-my-zsh.sh

PATH=bin:/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH:$HOME/bin:/usr/local/share/npm/bin
export PATH

NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

export EDITOR='vim'
export LESS=-R

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

alias rspec="nocorrect rspec"
alias grunt="nocorrect grunt"
