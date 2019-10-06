#!/usr/bin/env bash

# Exit on the first failing command
set -e

apt_install_cmd="sudo apt --assume-yes --quiet install"
pip_install_cmd="sudo pip3 install"
dev_folder=$HOME/Documents/dev
urxvt_plugin_folder=/usr/lib/urxvt/perl

my_github_repo="https://github.com/derteta"
urxvt_plugin_repo="https://raw.githubusercontent.com/muennich/urxvt-perls/master"

echo "===== Installing Development Tools ====="
$apt_install_cmd build-essential python3 python3-pip perl git
$pip_install_cmd nose mock

echo "===== Installing Terminal Environment ====="
$apt_install_cmd fzf ripgrep bash-completion curl
#TODO install geeknote

echo "===== Setting up URXVT Plugins ====="
sudo mkdir -p $urxvt_plugin_folder
sudo curl -o $urxvt_plugin_folder/keyboard-select $urxvt_plugin_repo/keyboard-select
sudo curl -o $urxvt_plugin_folder/url-select $urxvt_plugin_repo/deprecated/url-select

echo "===== Setting up Development Projects ====="
mkdir -p $dev_folder/third-party
git clone $my_github_repo/vimpair.git $dev_folder/vimpair
git clone $my_github_repo/dotfiles.git $dev_folder/dotfiles
git clone $my_github_repo/dev-blog.git $dev_folder/dev-blog
git clone https://github.com/vim/vim.git $dev_folder/third-party/vim

echo "===== Installing Windowing Environment ====="
$apt_install_cmd lightdm i3wm rofi rxvt-unicode xserver-xorg-input-synaptics \
  nm-applet volumeicon libnotify-bin flameshot \
  firefox-esr thunderbird
$pip_install_cmd spotify-cli-linux
curl -o $HOME/Pictures/wallpaper.jpg https://images4.alphacoders.com/589/589406.jpg

echo "===== Setting up Dotfiles ====="
sh $dev_folder/dotfiles/update-dotfiles.sh

echo "===== Setting up Vim ====="
git clone $my_github_repo/vim-config.git $HOME/.vim
(cd $HOME/.vim; sh setup.sh; sh build_vim.sh $dev_folder/third-party/vim)
