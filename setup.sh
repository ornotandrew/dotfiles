#!/bin/bash
# Symlink the dotfiles in this repo to the correct directory on the filesystem
LINK="ln -sn"

# The -f flag will overwrite any existing files
read -r -p  "Would you like to overwrite existing dotfiles? [y/N] " response
[[ ${response,,} =~ ^(yes|y)$ ]] && LINK+="f"

link()
{
    # If we specify a directory, link to that
    if [ -n "$2" ]
    then
        mkdir -p `dirname $2` # make sure the path exists
        $LINK `realpath -s $1` `realpath -s $2` 2>/dev/null \
            && echo "+ Linked $1 to $2" \
            || echo "- $2 already exists"

    # Otherwise, link to the home dir of the current user
    else
        $LINK `realpath -s $1` $HOME/$1 2>/dev/null \
            && echo "+ Linked $1 to ~" \
            || echo "- $HOME/$1 already exists"
    fi
}

# zsh
link .zshrc
link wraithy.zsh-theme ~/.oh-my-zsh/custom/themes/wraithy.zsh-theme

# vim
link .vim
link .vimrc

# nvim
link .vim ~/.config/nvim
link .vimrc ~/.config/nvim/init.vim

# git
link .gitconfig

# mercurial
link .hgrc

# pylint
link .pylintrc

echo
echo "Finished linking dotfiles"
echo

