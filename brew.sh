#!/usr/bin/env bash

# install powerline fonts
~/fonts/install.sh

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install GNU `grep
brew install grep --with-default-names
# Install more recent version of vim
brew install vim --override-system-vi

# Install other useful binaries.
brew install git
brew install the_silver_searcher
brew install tree
brew install tmux
brew install wget
brew install jq

# node
brew install nvm
nvm install node

# yarn package management
brew install yarn

# go
brew install go

# haskell
brew install haskell-stack

# cask
brew tap caskroom/cask
brew install brew-cask

# web dev tools
brew install imagemagick

# for envsubst
brew install gettext
brew link --force gettext

brew install kubectl

brew cask install gimp
brew cask install hipchat
brew cask install google-chrome
brew cask install sequel-pro
brew cask install skype
brew cask install slack
brew cask install vlc
brew cask install docker
brew cask install minikube
brew cask install visual-studio-code

# Remove outdated versions from the cellar.
brew cleanup
