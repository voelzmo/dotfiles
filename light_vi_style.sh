#!/bin/sh
set -e

sed -i '' -e 's/set background=dark/set background=light/g' ~/.config/nvim/init.vim
