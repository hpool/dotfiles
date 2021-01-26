#!/bin/sh -x

# Homebrewを最新版にアップデート
brew update

# Formulaを更新
brew upgrade

brew install awscli
brew install direnv
brew install erlang
brew install fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
brew install git
brew install gnu-prolog
brew install go
brew install hg
brew install io
brew install jq
brew install leiningen
brew install lv
#brew install anyenv
brew install readline
brew install sbt
brew install scala
brew install tmux
brew install tree
brew install wget
brew install w3m
brew install xz
brew install zsh
brew install the_silver_searcher

brew tap homebrew/binary
brew install packer

brew tap laurent22/massren
brew install massren

# インストール
brew install --cask dash
brew install --cask franz
brew install --cask gimp
brew install --cask google-chrome
brew install --cask google-japanese-ime
brew install --cask hyperswitch
brew install --cask iterm2
brew install --cask imageoptim
brew install --cask karabiner-elements
brew install --cask pycharm
brew install --cask goland
brew install --cask virtualbox
brew install --cask vagrant

brew cleanup
