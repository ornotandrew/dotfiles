#!/bin/bash
folders=$(find ~/code/* -maxdepth 0 -type d -not -name 'wraithy.github.io')
for dir in $folders; do
    echo $dir
    cd $dir
    excludes="--exclude=*.min.js"
    [ -e .hgignore ] && excludes+=" --exclude=@.hgignore"
    [ -e .gitignore ] && excludes+=" --exclude=@.gitignore"
    ctags -R $excludes 2>&1
done
