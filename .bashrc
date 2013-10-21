alias ll='ls -lph'

PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH:$HOME/bin
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
