#!/bin/sh
set -e

brew uninstall neovim
brew uninstall ctags

brew install fzf
brew install npm
brew install ripgrep
brew install python
brew install neovim
pip3 install --upgrade neovim

if ! grep -q nvim ~/.bash_profile; then
        echo 'alias vi=nvim' >> ~/.bash_profile
        echo 'alias vim=nvim' >> ~/.bash_profile
fi

mkdir -p ~/.config
rm -rf ~/.config/nvim
git clone https://github.com/luan/nvim ~/.config/nvim

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo "please wait until nvim updates"
nvim
