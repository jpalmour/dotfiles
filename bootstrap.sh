#!/bin/zsh

cd "$(dirname "$0")"

git pull origin master
git submodule update

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" -avh --no-perms . ~;
	source ~/.zshrc;
}

doIt
