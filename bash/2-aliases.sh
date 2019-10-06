#!/usr/bin/env bash

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'

alias gn='geeknote'
alias e_bash='$EDITOR ~/.config/derteta/bash'
alias e_i3='$EDITOR ~/.config/i3/config'

alias show_time='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
alias weather='curl wttr.in'
