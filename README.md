## Install instructions

```sh
# install homebrew
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# clone this repo
$ git clone --recursive

# copy dotfiles and configure some things
$ ./install

# install apps using homebrew. This need to happen after the config files have been copied by the ./install script
$ brew bundle

# install automated brew uprades
$ ./brew-auto-update/install.sh

# install umlauts with option key layout
$ curl -O -L -J http://hci.rwth-aachen.de/tiki-download_wiki_attachment.php?attId=793&page=USGermanKeyboard
$ unzip USGerman\ Keyboard\ Layout\ 0.98.zip
$ sudo mv USGerman\ Keyboard\ Layout\ 0.98/Roman.bundle /Library/Keyboard\ Layouts/
$ rm -rf USGerman\ Keyboard\ Layout\ 0.98

# install atom packages
$ apm install `cat atom_packages.list`
```


## TODO

* use rubymine profile


## Backup Instructions

```sh
# backup atom packages
$ apm list --installed --bare > atom_packages.list

# backup homebrew packages
$ brew bundle dump --force
```
