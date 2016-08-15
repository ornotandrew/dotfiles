#!/bin/bash
# Some basic packages and tweaks to make Unity on Ubuntu usable

if [[ $EUID -eq 0 ]]; then
   echo "This script must not be run as root" 1>&2
   exit 1
fi

# packages
sudo apt-add-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:numix/ppa
sudo apt update
sudo apt install -y \
    fonts-hack-ttf \
    neovim \
    numix-gtk-theme \
    numix-icon-theme-circle \
    python-pip \
    python3-pip \
    software-properties-common \
    silversearcher-ag \
    unity-tweak-tool \
    zsh

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# neovim
pip install neovim
pip3 install neovim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

# unity dash
dconf write /com/canonical/unity/dash/scopes "['home.scope', 'applications.scope', 'files.scope']"

# venvwrapper
pip3 install virtualenvwrapper
