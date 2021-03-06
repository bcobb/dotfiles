export LESS="-R"
export EDITOR=emacsclient
export BREW_PREFIX=/usr/local/opt
export VAGRANT_DEFAULT_PROVIDER=virtualbox

if [ -d ~/lib/go ] ; then
  export GOPATH=$(stat -f ~/lib/go)
  export GOBIN=$GOPATH/bin
fi

export LC_ALL=en_US.UTF-8

alias ll='ls -lph'

PATH=bin:node_modules/.bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:$PATH:$HOME/bin:$GOBIN
export PATH

LEIN_FAST_TRAMPOLINE=y
export LEIN_FAST_TRAMPOLINE
alias cljsbuild="lein trampoline cljsbuild $@"

if [ -d $BREW_PREFIX/chruby/share/chruby ] ; then
  source $BREW_PREFIX/chruby/share/chruby/chruby.sh
  source $BREW_PREFIX/chruby/share/chruby/auto.sh

  [ -f .ruby-version ] || chruby 2.1
fi

if [ -d $BREW_PREFIX/../etc/bash_completion.d/ ] ; then
 if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi

  source $BREW_PREFIX/../etc/bash_completion.d/git-completion.bash
  source $BREW_PREFIX/../etc/bash_completion.d/ag.bashcomp.sh
  source $BREW_PREFIX/../etc/bash_completion.d/npm
  source $BREW_PREFIX/../etc/bash_completion.d/tmux
  source $BREW_PREFIX/../etc/bash_completion.d/lein-completion.bash
fi

USER_COLOR='\e[38;05;85m'
HOST_COLOR=$USER_COLOR
PATH_COLOR='\e[38;05;244m'
BRANCH_COLOR='\e[38;05;193m'
SEPARATOR_COLOR='\e[38;05;71m'
CEND='\e[0m'

color_palette() {
  for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done
}

in_git_repo() {
  git status &> /dev/null
}

in_new_git_repo() {
  git status | grep 'Initial commit' &> /dev/null
}

prompt_command() {
  if in_git_repo; then
    if in_new_git_repo; then
      branch_display="\[\e[$BRANCH_COLOR\]master\[$CEND\]"
    else
      git_branch=$(git rev-parse --abbrev-ref HEAD)
      branch_display="\[\e[$BRANCH_COLOR\]$git_branch\[$CEND\]"
    fi

    status_length=$(git status -s | wc -l)

    if [ $status_length -ne 0 ]; then
      ADDENDUM="$branch_display*"
    else
      ADDENDUM="$branch_display"
    fi

    ADDENDUM=" ($ADDENDUM) "
  else
    ADDENDUM=' '
  fi

  set_ps1
}

set_ps1() {
  PS1="\[$USER_COLOR\]\u\[$CEND\]@\[$HOST_COLOR\]\h\[$CEND\] \[$PATH_COLOR\]\W\[$CEND\]$ADDENDUM\[$SEPARATOR_COLOR\]$\[$CEND\] "
}

set_ps1

PROMPT_COMMAND='prompt_command'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [ -f $HOME/.bashrc ] ; then
  source $HOME/.bashrc
fi
