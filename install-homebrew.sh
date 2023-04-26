#!/usr/bin/env bash
if [ ! -f "`which brew`" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo 'homebrew already installed, doing nothing.'
fi