## What is this?

A collection of system settings and installations, maintained using [dotbot](https://github.com/anishathalye/dotbot)

## Install instructions

```sh
# install apple developer tools
$ xcode-select --install
```

# clone this repo
$ git clone --recursive

# copy dotfiles and configure some things
$ ./install

# install apps using homebrew. This need to happen after the config files have been copied by the ./install script
$ brew bundle

# install umlauts with option key layout
$ curl -O -L -J http://hci.rwth-aachen.de/tiki-download_wiki_attachment.php?attId=793&page=USGermanKeyboard
$ unzip USGerman\ Keyboard\ Layout\ 0.98.zip
$ sudo mv USGerman\ Keyboard\ Layout\ 0.98/Roman.bundle /Library/Keyboard\ Layouts/
$ rm -rf USGerman\ Keyboard\ Layout\ 0.98

# change default login keyboard
$ sudo cp ~/Library/Preferences/com.apple.HIToolbox.plist /Library/Preferences/
```

## Backup Instructions

```sh
# backup homebrew packages
$ brew bundle dump --force
```
