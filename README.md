## What is this?

A collection of system settings and installations, maintained using [dotbot](https://github.com/anishathalye/dotbot)

## Install instructions

```sh
# install apple developer tools
$ xcode-select --install

# clone this repo
$ git clone --recursive https://github.com/voelzmo/dotfiles.git ~/workspace/dotfiles
$ cd ~/workspace/dotfiles

# install homebrew, link the config files, then install apps (brew bundle),
# ruby (mise) and the kubectl/gcloud plugins. Safe to re-run.
$ ./install
```

### Optional: umlauts with option key layout

See https://hci.rwth-aachen.de/usgermankeyboard

```sh
$ curl -O -L -J https://hci.rwth-aachen.de/get-attachment/2764?fallback=/files/migrated/files/USGerman-Keyboard-Layout-0.98-Retina.zip&filename=USGerman%20Keyboard%20Layout%200.98%20Retina.zip
$ unzip USGerman\ Keyboard\ Layout\ 0.98\ Retina.zip
$ sudo mv USGerman\ Keyboard\ Layout\ 0.98\ Retina/Roman.bundle /Library/Keyboard\ Layouts/
$ rm -rf USGerman\ Keyboard\ Layout\ 0.98\ Retina

# change default login keyboard
$ sudo cp ~/Library/Preferences/com.apple.HIToolbox.plist /Library/Preferences/
```

## Backup Instructions

```sh
# backup homebrew packages. Review the diff afterwards: brew also dumps transitive
# dependencies as if you had picked them, remove those again.
$ brew bundle dump --force

# backup kubectl plugins
$ kubectl krew list > kubectl-krew-plugins.txt

# export Rectangle settings from menu to RectangleConfig.json

# export iterm2 configuration from menu
```
