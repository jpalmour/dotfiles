# add airline theme to shell prompt, created by https://github.com/edkolev/promptline.vim
source ~/shell-prompt-airline-theme.sh

# zsh plugins
plugins=(git, docker, brew, npm, tmux)

# oh my zsh
source $ZSH/oh-my-zsh.sh

# nvm for node version management
source $(brew --prefix nvm)/nvm.sh

# use chruby for ruby version management
source /usr/local/opt/chruby/share/chruby/chruby.sh

# enable auto-switching of rubies specified by  .ruby-version files
source /usr/local/opt/chruby/share/chruby/auto.sh

