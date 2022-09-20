#!/bin/sh -x

# Homebrewを最新版にアップデート
brew update

# Formulaを更新
brew upgrade

brew install awscli
brew install direnv
# brew install erlang
brew install fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
brew install git
# brew install gnu-prolog
brew install go
# brew install hg
# brew install io
brew install jq
# brew install leiningen
brew install lv
# brew install anyenv
brew install readline
#brew install sbt
# brew install scala
brew install tmux
brew install tree
brew install wget
# brew install w3m
# brew install xz
brew install zsh
brew install the_silver_searcher

# brew tap homebrew/binary
# brew install packer

# brew tap laurent22/massren
# brew install massren

# インストール
# brew install dash
# brew install gimp
brew install google-chrome
brew install google-japanese-ime
brew install iterm2
brew install imageoptim
brew install karabiner-elements
brew install goland

brew cleanup
