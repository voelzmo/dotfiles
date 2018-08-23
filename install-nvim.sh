#!/bin/sh
set -e

brew install neovim

# TODO python/ruby?

if ! grep -q nvim ~/.bash_profile; then
        echo 'alias vi=nvim' >> ~/.bash_profile
fi

mkdir -p ~/.config
cd ~/.config && git clone https://github.com/manno/nvim-config-pairing nvim

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

nvim
