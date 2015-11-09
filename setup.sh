#!/bin/bash
# Symlink the dotfiles in this repo to the correct directory on the filesystem

# Links a file to the home dir of the current user
link()
{
    echo "Linking $1"
    ln -f -s `readlink -f $1` $HOME/$1
}

# zsh
link .zshrc

# vim
link .vimrc
link .vim

# git
link .gitconfig

# pylint
link .pylintrc

echo
echo "Finished linking dotfiles"
echo

