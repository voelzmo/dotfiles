#!/bin/bash

cd /tmp
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
cd ..
rm -rf fonts
