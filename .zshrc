# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

# zsh plugins
plugins=(git)

# source dotfiles
for file in ~/.{path,exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# source work stuff
source ~/work/.work

source $ZSH/oh-my-zsh.sh
source $(brew --prefix nvm)/nvm.sh

export PATH="/usr/local/sbin:$PATH"
