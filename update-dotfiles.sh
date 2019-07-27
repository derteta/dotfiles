#!/usr/bin/env bash

repo_url=https://raw.githubusercontent.com/derteta/dotfiles/master
bash_dir=~/.config/derteta/bash
bashrc_path=~/.bashrc
inputrc_path=~/.inputrc

[ ! -d $bash_dir ] && mkdir -p $bash_dir
for f in 1-general 2-aliases 3-dev
do
  curl -o $bash_dir/$f.sh $repo_url/bash/$f.sh
done

[ -f $bashrc_path ] && cp $bashrc_path $bashrc_path.old
echo 'for f in $(ls '$bash_dir'/*.sh); do source $f; done' > $bashrc_path

[ -f $inputrc_path ] && cp $inputrc_path $inputrc_path.old
curl -o $inputrc_path $repo_url/misc/.inputrc
