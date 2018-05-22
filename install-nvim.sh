#!/bin/sh
set -e

brew install neovim

# TODO python/ruby?

if ! grep -q nvim ~/.bash_profile; then
        echo 'alias vi=nvim' >> ~/.bash_profile
fi

mkdir -p ~/.config
cd ~/.config && git clone https://github.com/manno/nvim-config-pairing nvim
cd ~/.config/nvim && git fetch && git reset origin/master --hard

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

nvim
