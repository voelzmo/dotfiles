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

# apps only reread their preferences on start, launchd restarts the Dock right away
killall Dock || true
