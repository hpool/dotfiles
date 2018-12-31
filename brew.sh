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

brew tap peco/peco
brew install peco

# homebrew-caskのインストール
brew tap phinze/homebrew-cask
brew install brew-cask

brew tap caskroom/versions
#brew tap hpool/mycask

# インストール
#brew cask install clamxav
brew cask install dash
brew cask install dropbox
brew cask install firefox
brew cask install franz
brew cask install macvim-kaoriya
brew cask install gimp
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-japanese-ime
brew cask install hyperswitch
brew cask install iterm2-beta
brew cask install imageoptim
brew cask install karabiner
brew cask install libreoffice
brew cask install pycharm
brew cask install skype
brew cask install virtualbox
brew cask install vagrant

brew cleanup
