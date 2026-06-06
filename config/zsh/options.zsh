autoload -U compinit colors
colors
compinit

# Configure history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

# Ignore duplicate adjacent commands
setopt HIST_IGNORE_DUPS

# Start command with space to ignore in history
setopt HIST_IGNORE_SPACE

# Expand -> run
setopt HIST_VERIFY

# Sessions can share history
setopt SHARE_HISTORY

# Save timestamps in history
setopt EXTENDED_HISTORY

# cd pushes to directory stack
setopt AUTO_PUSHD

# Ignore duplicates in directory stack
setopt PUSHD_IGNORE_DUPS

# Allow #, ~, ^ as glob patterns
setopt EXTENDED_GLOB

# Include dotfiles in glob
setopt GLOB_DOTS

# Case-insensitive glob
setopt NO_CASE_GLOB

# No terminal bell
setopt NO_BEEP

# Correct spelling (commands only)
setopt CORRECT

# Report command run time if > 3s
REPORTTIME=3

zstyle ':completion:*' completer _complete _correct _approximate

# Emacs keybindings
bindkey -e
