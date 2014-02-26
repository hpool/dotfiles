
MANUAL_DIR=$HOME/.vim/manual/php
DOWNLOAD_DIR=/tmp/vim_php_manual-$$
DOWNLOAD_FILE=$DOWNLOAD_DIR/php_manual.tgz
MANUAL_URL=http://www.php.net/get/php_manual_en.tar.gz/from/jp1.php.net/mirror

setup_vim_php_manual()
{
    if [ -e $MANUAL_DIR ]; then
        return
    fi

    install -d $DOWNLOAD_DIR
    wget $MANUAL_URL -O $DOWNLOAD_FILE
    cd $DOWNLOAD_DIR
    tar xzf $DOWNLOAD_FILE
    install -d $MANUAL_DIR
    find $DOWNLOAD_DIR -name '*.html' | xargs -I{} mv {} $MANUAL_DIR
    rm -rf $DOWNLOAD_DIR
}

setup_vim_php_manual
