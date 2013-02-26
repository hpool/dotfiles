#!/bin/bash

DOTFILES=(
.ackrc
.gvimrc
.inputrc
.screenrc
.tmux.conf
.vim
.vimrc
.zshrc
)

setup()
{
    initialize
    symlink_dotfiles
}

initialize()
{
    for dotfile in ${DOTFILES[@]}
    do
        rm -rf $HOME/$dotfile
    done
}

symlink_dotfiles()
{
    for dotfile in ${DOTFILES[@]}
    do
        ln -sf $CURRENT_DIR/$dotfile $HOME/$dotfile
    done
}

CURRENT_DIR=`pwd dirname $0`
setup
