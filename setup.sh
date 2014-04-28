#!/bin/sh

setup()
{
    initialize
    symlink_files $CURRENT_DIR/setup-symlink.conf
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
}

symlink_files()
{
    while read FILE
    do
        if [ -e $HOME/$FILE ]; then
            echo rm -rf $HOME/$FILE
        fi
        echo ln -sf $CURRENT_DIR/$FILE $HOME/$FILE
    done < $1
}


CURRENT_DIR=$(cd $(dirname $0);pwd)
setup

