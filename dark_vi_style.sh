#!/bin/sh
set -e

sed -i '' -e 's/set background=light/set background=dark/g' ~/.config/nvim/init.vim
