#!/usr/bin/env bash

set -o vi
export TERM=xterm-256color
export EDITOR=vim
export LC_ALL=C

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

for conf in /usr/share/bash-completion/bash_completion \
  /usr/share/doc/fzf/examples/key-bindings.bash \
  $HOME/.config/fzf.sh
do
  [ -f $conf ] && . $conf
done
