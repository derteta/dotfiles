#!/usr/bin/env bash

# Exit on the first failing command
set -e

export DEBIAN_FRONTEND=noninteractive
apt_install_cmd="sudo apt --assume-yes --quiet install"
pip_install_cmd="sudo pip3 install"
dev_folder=$HOME/Documents/dev
urxvt_plugin_folder=/usr/lib/urxvt/perl

my_github_repo="https://github.com/derteta"
urxvt_plugin_repo1="https://raw.githubusercontent.com/muennich/urxvt-perls/master"
urxvt_plugin_repo2="https://raw.githubusercontent.com/majutsushi/urxvt-font-size/master"

for folder in Desktop Documents Downloads Movies Music Pictures
do
  [ ! -d $HOME/$folder ] && mkdir -p $HOME/$folder
done
[ ! -d $dev_folder/forks ] && mkdir -p $dev_folder/forks
[ ! -d $dev_folder/third-party ] && mkdir -p $dev_folder/third-party
[ ! -d $urxvt_plugin_folder ] && sudo mkdir -p $urxvt_plugin_folder

echo "===== Upgrading to Debian testing ====="
echo "deb http://ftp.de.debian.org/debian/ testing main contrib non-free" | sudo tee /etc/apt/sources.list
echo "deb-src http://ftp.de.debian.org/debian/ testing contrib main" | sudo tee -a /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security testing-security main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security testing-security main" | sudo tee -a /etc/apt/sources.list

sudo apt --assume-yes --quiet update
sudo apt --assume-yes --quiet upgrade
sudo apt --assume-yes --quiet dist-upgrade

echo "===== Installing Development Tools ====="
$apt_install_cmd build-essential python3 python3-pip perl git
$pip_install_cmd nose mock

echo "===== Installing Terminal Environment ====="
$apt_install_cmd fzf ripgrep bash-completion curl ncurses-dev

echo "===== Setting up URXVT Plugins ====="
[ ! -f $urxvt_plugin_folder/keyboard-select ] && \
  sudo curl -o $urxvt_plugin_folder/keyboard-select $urxvt_plugin_repo1/keyboard-select
[ ! -f $urxvt_plugin_folder/url-select ] && \
  sudo curl -o $urxvt_plugin_folder/url-select $urxvt_plugin_repo1/deprecated/url-select
[ ! -f $urxvt_plugin_folder/font-size ] && \
  sudo curl -o $urxvt_plugin_folder/fond-size $urxvt_plugin_repo2/font-size

echo "===== Setting up Development Projects ====="
[ ! -d $dev_folder/third-party/vim ] && \
  git clone https://github.com/vim/vim.git $dev_folder/third-party/vim
[ ! -d $dev_folder/forks/geeknote ] && \
  git clone $my_github_repo/geeknote.git $dev_folder/forks/geeknote
for project in vimpair dotfiles dev-blog
do
  [ ! -d $dev_folder/$project ] && \
    git clone $my_github_repo/$project.git $dev_folder/$project
done

echo "===== Installing Windowing Environment ====="
$apt_install_cmd lightdm i3 rofi rxvt-unicode xserver-xorg-input-synaptics \
  volumeicon-alsa libnotify-bin flameshot \
  firefox-esr thunderbird
$pip_install_cmd spotify-cli-linux
curl -o $HOME/Pictures/wallpaper.jpg https://images4.alphacoders.com/589/589406.jpg
# optional packages: wicd-gtk (seems to be removed from testing/unstable)

echo "===== Setting up Dotfiles ====="
sh $dev_folder/dotfiles/update-dotfiles.sh

echo "===== Setting up Vim ====="
[ ! -d $HOME/.vim ] && git clone $my_github_repo/vim-config.git $HOME/.vim
(cd $HOME/.vim; sh setup.sh; sh build_vim.sh $dev_folder/third-party/vim)
