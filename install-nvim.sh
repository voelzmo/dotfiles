#!/bin/sh
set -e

brew install neovim

# TODO python/ruby?

if ! grep -q nvim ~/.bash_profile; then
        echo 'alias vi=nvim' >> ~/.bash_profile
fi

cd ~/.config && git clone https://github.com/manno/nvim-config-pairing nvim

nvim
