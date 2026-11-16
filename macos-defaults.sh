#!/usr/bin/env bash
# Applies macOS preferences. Safe to re-run, nothing here needs sudo.
#
# Inspired by https://github.com/mathiasbynens/dotfiles/blob/main/.macos, but only the settings
# that are wanted here, checked against what a fresh macOS does by default.
#
# To find the key of a setting: run `defaults read > before.txt`, change it in System Settings,
# run it again into after.txt and diff the two.

set -euo pipefail

echo 'Dock'
# where it lives and that it gets out of the way
defaults write com.apple.dock orientation -string right
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 64
# show instantly when hovering and keep the animation short
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15
# less clutter and movement
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock launchanim -bool false

echo 'Finder'
# files: always show extensions (also avoids being fooled by invoice.pdf.exe) and don't warn when renaming them
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# folders first when sorting by name, and search the current folder instead of the whole Mac
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
# don't litter network shares and USB sticks with .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# also expand the "Sharing & Permissions" pane in Get Info. Adds to the other expanded panes instead of replacing them.
defaults write com.apple.finder FXInfoPanesExpanded -dict-add Privileges -bool true
# show ~/Library
chflags nohidden ~/Library

# apps only reread their preferences on start, launchd restarts them right away
killall Dock Finder || true
