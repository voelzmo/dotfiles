## What is this?

A collection of system settings and installations, maintained using [dotbot](https://github.com/anishathalye/dotbot)

## Install instructions

```sh
# install apple developer tools
$ xcode-select --install

# clone this repo
$ git clone --recursive https://github.com/voelzmo/dotfiles.git ~/workspace/dotfiles
$ cd ~/workspace/dotfiles

# install homebrew, clone voelzmo/k9s-plugins to ~/workspace and link the config files
# (including the k9s plugins), then install apps (brew bundle), ruby (mise) and the
# kubectl/gcloud plugins. Safe to re-run.
$ ./install
```

### Umlauts with option key layout

See https://hci.rwth-aachen.de/usgermankeyboard

`./install` downloads the layout (checksum-verified) and installs it to `/Library/Keyboard Layouts`,
which asks for your password on the first run. Two manual steps remain, because macOS only offers
the layout after a re-login:

1. Log out and in, then add the layout under System Settings > Keyboard > Input Sources.
2. Optionally make the login window use it as well:

```sh
$ ./install-keyboard-layout.sh --login-window
```

## Backup Instructions

```sh
# backup homebrew packages. Review the diff afterwards: brew also dumps transitive
# dependencies as if you had picked them, remove those again.
$ brew bundle dump --force

# backup kubectl plugins
$ kubectl krew list > kubectl-krew-plugins.txt

# export Rectangle settings from menu to RectangleConfig.json

# iterm2 loads its settings from com.googlecode.iterm2.plist in this repo (macos-defaults.sh sets that up).
# Settings > General > Settings controls when it writes changes back. Review the diff before committing.
# Don't use "Export All Settings and Data" for this: it includes the AI chat database and keychain entries.
```
