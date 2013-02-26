#!/bin/sh

DOTFILES=(
.ackrc
.gitconfig
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
    cd $CURRENT_DIR && git submodule update --init
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

CURRENT_DIR=$(cd $(dirname $0);pwd)
setup
