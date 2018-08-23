#!/bin/sh
set -e

cd ~/.config/nvim && git fetch && git reset origin/master --hard
