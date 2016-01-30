# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

# zsh plugins
plugins=(git)

for file in ~/.{aliases,functions,work}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh

# RVM
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export EDITOR=vim

# tmux
# prevent window names from not showing properly in tmuxinator
export DISABLE_AUTO_TITLE=true
