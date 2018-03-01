# Joseph's dotfiles

### Installation
1. Install [Homebrew](http://brew.sh/)
2. Install zsh: `brew install zsh zsh-completions`
3. Default to zsh: `sudo sh -c "echo $(which zsh) >> /etc/shells"` then `chsh -s $(which zsh)`
4. Clone repo somewhere other than ~, `cd` into repository, and then execute: `source bootstrap.sh`
5. Install Homebrew formulae: `./brew.sh`
6. Update OS X settings: `./.osx`
