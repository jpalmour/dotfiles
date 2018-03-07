#!/bin/zsh

cd "$(dirname -- "$0")"

git pull origin master
git submodule update --init --recursive

function doIt() {
	rsync --exclude ".git/"\
	      --exclude ".DS_Store"\
	      --exclude "bootstrap.sh"\
	      --exclude "README.md"\
	      --exclude "*.swp"\
	      -avh\
		  --no-perms\
		  . ~;

    # install brew if not already installed
	command -v brew > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# install zsh if not already installed
	command -v zsh > /dev/null || brew install zsh

	# install oh-my-zsh if not already installed
	[[ -d $HOME/.oh-my-zsh ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	source ~/.zshenv;
	source ~/.zshrc;

	# generate work .ssh
	./work/.ssh/copy-ssh-config.sh

	# to avoid errors when pulling private repos using go get
	git config --global url."https://${JPALMOUR_GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"

	# install things managed by brew
	~/brew.sh
	
}

doIt
