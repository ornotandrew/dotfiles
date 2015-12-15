#!/bin/bash
# Symlink the dotfiles in this repo to the correct directory on the filesystem

link()
{
    # If we specify a directory, link to that
    if [ -n "$2" ]
    then
        echo "Linking $1 to $2"
        ln -s `readlink -f $1` `readlink -f $2`

    # Otherwise, link to the home dir of the current user
    else
        echo "Linking $1 to ~"
        ln -s `readlink -f $1` $HOME/$1
    fi
}

# zsh
link .zshrc

# vim
link .vim
link .vimrc
link .vim ~/.config/nvim
link .vimrc .vim/init.vim

# git
link .gitconfig

# mercurial
link .hgrc

# pylint
link .pylintrc

echo
echo "Finished linking dotfiles"
echo

