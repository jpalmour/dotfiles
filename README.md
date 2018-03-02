# Joseph's dotfiles

### Installation
1. Install [Homebrew](http://brew.sh/)
2. Install zsh: `brew install zsh zsh-completions`
3. Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh): `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
4. Default to zsh: `sudo sh -c "echo $(which zsh) >> /etc/shells"` then `chsh -s $(which zsh)`
5. Clone repo somewhere other than ~, `cd` into repository, and then execute: `source bootstrap.sh`
6. Install Homebrew formulae: `./brew.sh`
7. Update OS X settings: `./.osx`
