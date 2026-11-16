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

echo 'General UI'
# open the save and print dialogs expanded
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# save new documents to disk, not to iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# no delay before the file name shows up when hovering over a window title
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
# quit the printer app once the print jobs are done
defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true

echo 'Screenshots'
# macOS doesn't create the folder and silently falls back to the Desktop when it is missing
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
# no drop shadow around window screenshots
defaults write com.apple.screencapture disable-shadow -bool true

echo 'iTerm'
# load the settings from com.googlecode.iterm2.plist in this repo instead of ~/Library/Preferences.
# iTerm reads this on start, so restart it afterwards. It is not restarted here, this script may run inside it.
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# apps only reread their preferences on start, launchd restarts them right away
# (SystemUIServer is the process behind the screenshot tool)
killall Dock Finder SystemUIServer || true
