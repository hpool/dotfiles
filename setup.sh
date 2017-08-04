#!/bin/sh

setup()
{
    initialize
    symlink_files $CURRENT_DIR/setup-symlink.conf
    dl_diff_highlight
}

setup_mac()
{
    if [ ! -e $HOME/.vimperatorrc ]; then
        echo source! $HOME/.vimperatorrc.local > $HOME/.vimperatorrc
    fi
    if [ ! -e $HOME/.vimperatorrc.local ]; then
        touch $HOME/.vimperatorrc.local
    fi
}

dl_diff_highlight()
{
    if [ ! -e $HOME/bin/diff-highlight ]; then
        if [ ! -e $HOME/bin ]; then
            mkdir $HOME/bin
        fi
        wget https://raw.githubusercontent.com/git/git/v2.13.0/contrib/diff-highlight/diff-highlight -P $HOME/bin/
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
            rm -rf $HOME/$FILE
        fi
        ln -sf $CURRENT_DIR/$FILE $HOME/$FILE
    done < $1
}


CURRENT_DIR=$(cd $(dirname $0);pwd)
setup
if [ `uname` = "Darwin" ]; then
    setup_mac
fi

