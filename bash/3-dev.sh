#!/usr/bin/env bash

alias gdb='gdb -q' # Quiet down gdb
alias gil='git log --graph --pretty=oneline --abbrev-commit --decorate=short'

gdrop_func()
{
  status="$(git status 2 > /dev/null | tail -n1)"
  no_changes="nothing to commit, working directory clean"
  if [ "$status" != "$no_changes" ]; then
    git stash
    git stash drop
  fi
}
alias gdrop=gdrop_func

alias gupstream='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias goroot='relative_path="$(git rev-parse --show-cdup)"; if [ "$relative_path" != "" ]; then cd $relative_path; fi'
alias gmod='(goroot && git submodule update --init --recursive)'
alias grev='git rev-parse'
alias gpick='git cherry-pick'
alias grmuntracked='git st --porcelain | grep ?? | sed "s/^?? //" | sed "s/^/\"/" | sed "s/$/\"/" | xargs rm -rf'

