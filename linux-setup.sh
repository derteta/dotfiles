#!/usr/bin/env bash

# Exit on the first failing command
set -e

export DEBIAN_FRONTEND=noninteractive
apt_install_cmd="sudo apt --assume-yes --quiet install"
pip_install_cmd="sudo pip3 install"
dev_folder=$HOME/Documents/dev

my_github_repo="https://github.com/derteta"

for folder in Desktop Documents Downloads Movies Music Pictures
do
  [ ! -d $HOME/$folder ] && mkdir -p $HOME/$folder
done
[ ! -d $dev_folder/forks ] && mkdir -p $dev_folder/forks
[ ! -d $dev_folder/third-party ] && mkdir -p $dev_folder/third-party

echo "===== Upgrading to Debian testing ====="
echo "deb http://ftp.de.debian.org/debian/ testing main contrib non-free" | sudo tee /etc/apt/sources.list
echo "deb-src http://ftp.de.debian.org/debian/ testing contrib main" | sudo tee -a /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security testing-security main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security testing-security main" | sudo tee -a /etc/apt/sources.list

sudo apt --assume-yes --quiet update
sudo apt --assume-yes --quiet upgrade
sudo apt --assume-yes --quiet dist-upgrade

echo "===== Installing Development Tools ====="
$apt_install_cmd build-essential python3 python3-pip perl git golang
$pip_install_cmd nose mock lazygit

echo "===== Installing Terminal Environment ====="
$apt_install_cmd fzf ripgrep bash-completion curl ncurses-dev xsel htop

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
$apt_install_cmd lightdm i3 compton rofi kitty xserver-xorg-input-synaptics \
  xserver-xorg-input-all volumeicon-alsa libnotify-bin flameshot \
  firefox-esr thunderbird keynav feh thunar cups
$pip_install_cmd spotify-cli-linux
curl -o $HOME/Pictures/wallpaper.jpg https://images4.alphacoders.com/589/589406.jpg
# optional packages: wicd-gtk (seems to be removed from testing/unstable)

echo "===== Setting up Dotfiles ====="
sh $dev_folder/dotfiles/update-dotfiles.sh

echo "===== Setting up Vim ====="
[ ! -d $HOME/.vim ] && git clone $my_github_repo/vim-config.git $HOME/.vim
(cd $HOME/.vim; sh setup.sh; sh build_vim.sh $dev_folder/third-party/vim)
