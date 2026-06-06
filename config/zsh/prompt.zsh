autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:git:*' formats ' (%b)'   # branch name in parens

setopt PROMPT_SUBST

# Colors: use %F{color} / %f — terminal palette handles the actual RGB
PROMPT='%F{cyan}%~%f%F{yellow}${vcs_info_msg_0_}%f %F{green}❯%f '
RPROMPT='%F{red}%(?..[%?])%f'  # show exit code on right, only when nonzero

export COLORTERM='truecolor'
export CLICOLOR=1
