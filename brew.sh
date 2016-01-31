#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/php/php56 --with-gmp

# Install other useful binaries.
brew install ack
brew install git
brew install tree
brew install tmux
brew install wget

# go
brew install go

# php
brew install composer

# cask
brew tap caskroom/cask
brew install brew-cask

brew cask install dockertoolbox
brew cask install evernote
brew cask install google-chrome
brew cask install hipchat
brew cask install iterm2
brew cask install sequel-pro
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc

# Remove outdated versions from the cellar.
brew cleanup