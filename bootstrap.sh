#!/bin/zsh

cd "$(dirname "$0")"

git pull origin master
git submodule update

function doIt() {
	rsync --exclude ".git/" \
	      --exclude ".DS_Store" \
	      --exclude "bootstrap.sh" \
	      --exclude "README.md" ] \
	      --exclude "*.swp" \
	      -avh --no-perms . ~;
	source ~/.zshenv;
	source ~/.zshrc;

	# generate work .ssh
	./work/copy-ssh-config.sh

	# to avoid errors when pulling private repos using go get
	git config --global url."https://${JPALMOUR_GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
	
}

doIt
