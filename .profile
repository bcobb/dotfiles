export BREW_PREFIX=/usr/local/opt

alias ll='ls -lph'

PATH=bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:$PATH:$HOME/bin
export PATH

source $BREW_PREFIX/chruby/share/chruby/chruby.sh
source $BREW_PREFIX/chruby/share/chruby/auto.sh
source $BREW_PREFIX/git/etc/bash_completion.d/git-completion.bash

[ -f .ruby-version ] || chruby 2.1

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

prompt_command() {
  if in_git_repo; then
    git_branch=$(git rev-parse --abbrev-ref HEAD)
    status_length=$(git status -s | wc -l)

    ADDENDUM="\[\e[$BRANCH_COLOR\]$git_branch\[$CEND\]"

    if [ $status_length -ne 0 ]; then
      ADDENDUM="$ADDENDUM*"
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
