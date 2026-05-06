## What is this?

A collection of system settings and installations, maintained using [dotbot](https://github.com/anishathalye/dotbot)

## Install instructions

```sh
# install apple developer tools
$ xcode-select --install

# clone this repo
$ git clone --recursive

# copy dotfiles and configure some things
$ ./install

# install apps using homebrew. This need to happen after the config files have been copied by the ./install script
$ brew bundle

# install umlauts with option key layout
$ curl -O -L -J https://hci.rwth-aachen.de/get-attachment/2764?fallback=/files/migrated/files/USGerman-Keyboard-Layout-0.98-Retina.zip&filename=USGerman%20Keyboard%20Layout%200.98%20Retina.zip
$ unzip USGerman\ Keyboard\ Layout\ 0.98\ Retina.zip
$ sudo mv USGerman\ Keyboard\ Layout\ 0.98\ Retina/Roman.bundle /Library/Keyboard\ Layouts/
$ rm -rf USGerman\ Keyboard\ Layout\ 0.98\ Retina

# change default login keyboard
$ sudo cp ~/Library/Preferences/com.apple.HIToolbox.plist /Library/Preferences/
```

## Backup Instructions

```sh
# backup homebrew packages
$ brew bundle dump --force

# backup kubectl plugins
$ kubectl krew list > kubectl-krew-plugins.txt

# export Rectangle settings from menu to RectangleConfig.json

# export iterm2 configuration from menu
```
