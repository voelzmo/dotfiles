#!/usr/bin/env bash
# Installs the "USGerman Keyboard Layout 0.98 Retina" (umlauts via the option key),
# see https://hci.rwth-aachen.de/usgermankeyboard
#
#   ./install-keyboard-layout.sh                install the layout bundle (skipped if already there)
#   ./install-keyboard-layout.sh --login-window also make the login window use your input sources
#
# Both need sudo, because they write to /Library.
#
# The layout only shows up in System Settings > Keyboard > Input Sources after a re-login.
# Add it there first, and only then run with --login-window: that copies your current input
# sources, so doing it earlier would copy a list that doesn't contain the layout yet.

set -euo pipefail

URL='https://hci.rwth-aachen.de/get-attachment/2764?fallback=/files/migrated/files/USGerman-Keyboard-Layout-0.98-Retina.zip&filename=USGerman%20Keyboard%20Layout%200.98%20Retina.zip'
# pinned, as the zip ends up as root in /Library
SHA256='3d6f420185a7b104da45411c0a380d342606d3b20281984b30cac59fbae8fb39'
BUNDLE='/Library/Keyboard Layouts/Roman.bundle'

install_layout() {
  if [ -d "${BUNDLE}" ]; then
    echo 'keyboard layout already installed, doing nothing.'
    return
  fi

  local tmp
  tmp="$(mktemp -d)"
  trap 'rm -rf "${tmp}"' EXIT

  curl -fsSL -o "${tmp}/layout.zip" "${URL}"
  actual="$(shasum -a 256 "${tmp}/layout.zip" | cut -d' ' -f1)"
  if [ "${actual}" != "${SHA256}" ]; then
    echo "checksum mismatch for the keyboard layout zip: got ${actual}, expected ${SHA256}" >&2
    exit 1
  fi

  mkdir "${tmp}/extracted"
  unzip -q "${tmp}/layout.zip" -d "${tmp}/extracted"
  sudo cp -R "${tmp}/extracted/USGerman Keyboard Layout 0.98 Retina/Roman.bundle" "${BUNDLE}"
  sudo chown -R root:wheel "${BUNDLE}"
  echo 'keyboard layout installed. Log out and in, then add it under System Settings > Keyboard > Input Sources.'
}

login_window() {
  # the login window reads its input sources from here, the user ones live in ~/Library/Preferences
  sudo cp "${HOME}/Library/Preferences/com.apple.HIToolbox.plist" /Library/Preferences/
  echo 'login window input sources updated.'
}

case "${1:-}" in
  '') install_layout ;;
  --login-window) login_window ;;
  *) echo "usage: $0 [--login-window]" >&2; exit 2 ;;
esac
