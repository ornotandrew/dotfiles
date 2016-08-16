#!/bin/bash
for dir in ~/code/*/; do
    cd $dir
    excludes="--exclude=*.min.js"
    [ -e .hgignore ] && excludes+=" --exclude=@.hgignore"
    [ -e .gitignore ] && excludes+=" --exclude=@.gitignore"
    ctags -R $excludes 2>&1
done
