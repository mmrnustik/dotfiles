#!/bin/sh

link () {
    source=$PWD/$1
    dest=$HOME/$2
    if [ ! -e $dest ]
    then
        echo "  Creating symlink from" $1  "to" $2
        ln -s $source $dest
    else
        echo "  Symlink from" $1  "to" $2 "already exists"

    fi
}

link vimrc .vimrc
link tmux.conf .tmux.conf
link flake8 .config/flake8

