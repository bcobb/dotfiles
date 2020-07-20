export LESS="-R"
export EDITOR=emacsclient
export BREW_PREFIX="$(brew --prefix)"
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
alias unwrap_commit="git show -s head --pretty='%B' | unwrap"

if [ -d $BREW_PREFIX/share/chruby ] ; then
  source $BREW_PREFIX/share/chruby/chruby.sh
  source $BREW_PREFIX/share/chruby/auto.sh

  # for chruby.el
  # export RUBIES_DIR="~/.rbenv/versions"

  # for chruby itself
  # for version in $(ls ~/.rbenv/versions); do
  #   RUBIES+=(~/.rbenv/versions/$version)
  # done;

  # [ -f .ruby-version ] || chruby 2.5.1
fi

if [ -d $BREW_PREFIX/etc/bash_completion.d/ ] ; then
 if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi

  source $BREW_PREFIX/etc/bash_completion.d/git-completion.bash
  source $BREW_PREFIX/etc/bash_completion.d/ag.bashcomp.sh
  # source $BREW_PREFIX/etc/bash_completion.d/npm
  source $BREW_PREFIX/etc/bash_completion.d/tmux
  source $BREW_PREFIX/etc/bash_completion.d/lein-completion.bash
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

prompthost() {
  localhostname="`scutil --get LocalHostName`"
  iswork=$(echo $localhostname | grep -q MB)

  if $iswork; then
      echo "tusks"
  else
      echo $localhostname
  fi
}

isWork() {
    localname | grep -q MB
}

set_ps1() {
  local="`prompthost`"
  PS1="\[$USER_COLOR\]\u\[$CEND\]@\[$HOST_COLOR\]$local\[$CEND\] \[$PATH_COLOR\]\W\[$CEND\]$ADDENDUM\[$SEPARATOR_COLOR\]$\[$CEND\] "
}

set_ps1

PROMPT_COMMAND='prompt_command'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [ -f $HOME/.bashrc ] ; then
  source $HOME/.bashrc
fi

alias pr_message="git show -s --pretty='%B' | unwrap"
export PATH="/usr/local/opt/node@8/bin:$PATH"

# Functions for manipulating your environment for AWS profiles


# ave - run a command with 'aws-vault exec'
# Usage:
#   ave [ -p PROFILE] COMMAND
function ave () {
  # Using getopt in a function can be tricky: https://stackoverflow.com/a/16655341
  # We need to set these args as 'local'
  local OPTIND opt
  local profile=${AWS_PROFILE:-}
  while getopts "hp:" opt; do
    case $opt in
      p)
        profile="$OPTARG"
        shift
        shift
        ;;
      h)
        echo "Usage: ave [-p PROFILE] COMMAND" >&2
        return 1
        ;;
      ?)
        echo "Invalid option: -$OPTION $OPTARG" >&2
        return 1
        ;;
    esac
  done
  if [ -z "$profile" ]; then
    echo "ave: no profile provided: try 'ap PROFILE' or 'ave -p PROFILE'"
    return 1
  fi

  local is_admin=$(echo $profile | grep -qv admin; echo $?)
  local ttl="--assume-role-ttl=8h --no-session"
  # For admins, use the (max) 1 hour session which prevents having to re-enter
  # MFA on every request
  if [ $is_admin -eq 1 ]; then
    ttl="--assume-role-ttl=1h"
  fi
  aws-vault exec $ttl "$profile" -- "$@"
}

# ap - switch or show your AWS_PROFILE argument
# Usage
#   ap [PROFILE]
function ap () {
  if [[ $# -eq 1 ]]
    then
      export AWS_PROFILE=$1
  fi
  echo "AWS_PROFILE is set to $AWS_PROFILE"
}

# Export these functions so that they can be used from scripts
export -f ap
export -f ave

alias serveit="python -m SimpleHTTPServer 8000"
