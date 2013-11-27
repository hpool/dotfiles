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
.zsh
.zshrc
)

setup()
{
    initialize
    symlink_dotfiles
    dl_diff_highlight
}

dl_diff_highlight()
{
    if [ ! -e $HOME/bin/diff-highlight ]; then
        if [ ! -e $HOME/bin ]; then
            mkdir $HOME/bin
        fi
        wget https://raw.github.com/git/git/master/contrib/diff-highlight/diff-highlight -P $HOME/bin/
        chmod +x $HOME/bin/diff-highlight
    fi
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
