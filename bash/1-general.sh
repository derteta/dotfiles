#!/usr/bin/env bash

set -o vi
export TERM=xterm-256color
export EDITOR=vim
export LC_ALL=C

case $- in
  i ) ;;
  *) return;; #If not running interactively, don't do anything
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

[ -f ~/.config/fzf.sh ] && . ~/.config/fzf.sh

if ! shopt -oq posix; then
  for compl in /usr/share/bash-completion/bash_completion /etc/bash_completion
  do
    [ -f $compl ] && . $compl
  done
fi
