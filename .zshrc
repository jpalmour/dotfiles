# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# add airline theme to shell prompt, created by https://github.com/edkolev/promptline.vim
source ~/shell-prompt-airline-theme.sh

# zsh plugins
plugins=(git)

# source dotfiles
for file in ~/.{path,exports,aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

source ~/functions/*.sh

source ~/work/.work

source $ZSH/oh-my-zsh.sh
source $(brew --prefix nvm)/nvm.sh

export PATH="/usr/local/sbin:$PATH"
