#!/usr/bin/env bash

repo_url=https://raw.githubusercontent.com/derteta/dotfiles/master
bash_dir=~/.config/derteta/bash
bashrc_path=~/.bashrc
inputrc_path=~/.inputrc
i3status_path=~/.config/i3status/config

backup_file()
{
  path_to_file=$1
  [ -f $path_to_file ] && cp $path_to_file $path_to_file.old
}


[ ! -d $bash_dir ] && mkdir -p $bash_dir
for f in 1-general 2-aliases 3-dev
do
  curl -o $bash_dir/$f.sh $repo_url/bash/$f.sh
done

backup_file $bashrc_path
echo 'export PS1="\[\e[32m\]\A\[\e[m\] | \[\e[36m\]\w\[\e[m\] $ "' > $bashrc_path
echo 'for f in $(ls '$bash_dir'/*.sh); do source $f; done' >> $bashrc_path

backup_file $inputrc_path
curl -o $inputrc_path $repo_url/misc/.inputrc

if [ ! -z $(uname -s | grep -i Linux) ]; then
  backup_file $i3status_path
  curl -o $i3status_path $repo_url/i3status/config
fi
